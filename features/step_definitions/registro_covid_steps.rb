Dado('el afiliado {string} afiliado a {string}') do |nombre, plan|
  @id_afiliado_telegram = 'fake_id_telegram'
  request = {
    'nombre' => nombre,
    'nombre_plan' => plan,
    'id_telegram' => @id_afiliado_telegram,
    'cantidad_hijos' => 0,
    'edad' => 20,
    'conyuge' => false
  }
  response = Faraday.post(AFILIADOS_URL, request.to_json, 'Content-Type' => 'application/json', 'HTTP_API_KEY' => API_KEY)
  json_response = JSON.parse(response.body)
  @id_afiliado = json_response['id']
end

Cuando('se registra caso sospechoso de COVID') do
  @request = {
    'id_telegram' => 'fake_id_telegram'
  }
  @response = Faraday.post(COVID_URL, @request.to_json, 'Content-Type' => 'application/json')
end

Entonces('se obtiene que es sospechoso') do
  json_response = JSON.parse(@response.body)
  resultado = json_response['sospechoso']
  expect(@response.status).to eq 200
  expect(resultado).to be true
end

Entonces('queda registrado que el afiliado es sospechoso') do
  URL = "#{COVID_URL}/#{@id_afiliado}".freeze
  @response = Faraday.get(URL, @request.to_json, 'Content-Type' => 'application/json')
  json_response = JSON.parse(@response.body)

  resultado = json_response['sospechoso']
  expect(resultado).to be true
end
