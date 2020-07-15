Dado('el afiliado {string} afiliado a {string}') do |nombre, plan|
  request = {
    'nombre' => nombre,
    'nombre_plan' => plan
  }
  response = Faraday.post(AFILIADOS_URL, request.to_json, 'Content-Type' => 'application/json')
  json_response = JSON.parse(response.body)
  @id_afiliado = json_response['id']
end

Cuando('se realiza la consulta por COVID con temperatura {int}') do |int|
  @request = {
    'afiliado' => @id_afiliado,
    'temperatura' => int
  }
  @response = Faraday.post(COVID_URL, @request.to_json, 'Content-Type' => 'application/json')
end

Entonces('se obtiene que no es sospechoso') do
  json_response = JSON.parse(@response.body)

  resultado = json_response['resultado']
  expect(@response.status).to eq 200
  expect(resultado).not_to be 'Sospechoso'
end

Entonces('se obtiene que es sospechoso') do
  json_response = JSON.parse(@response.body)

  resultado = json_response['resultado']
  expect(@response.status).to eq 200
  expect(resultado).to be 'Sospechoso'
end

Entonces('queda registrado que el afiliado {string} es sospechoso') do |string|
  @request = {
    'afiliado' => string
  }
  json_afiliado = JSON.parse(@response_afiliado.body)
  id_afiliado = json_afiliado['id']
  URL = "#{COVID_URL}/#{id_afiliado}".freeze

  @response = Faraday.get(COVID_URL, @request.to_json, 'Content-Type' => 'application/json')
  json_response = JSON.parse(@response.body)

  resultado = json_response['resultado']
  expect(resultado).to be 'Sospechoso'
end
