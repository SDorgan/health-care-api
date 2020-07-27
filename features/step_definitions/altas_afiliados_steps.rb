Dado('el afiliado {string} de {int} años, conyuge {string}, hijos {int}') do |nombre, _anio, _conyuge, _hijos| # rubocop:disable LineLength
  @request = {
    'nombre' => nombre
  }
end

Dado('el usuario {string} que no esta afiliado') do |_string|
  @id_afiliado = 9_999_999
end

Cuando('se registra al plan {string}') do |plan|
  @request = {
    'nombre' => @request['nombre'],
    'nombre_plan' => plan
  }
  @response_afiliado = Faraday.post(AFILIADOS_URL, @request.to_json, 'Content-Type' => 'application/json')
end

Entonces('obtiene un numero unico de afiliado') do
  json_response = JSON.parse(@response_afiliado.body)

  id = json_response['id']
  expect(@response.status).to eq 201
  expect(id).not_to be_nil
end

Entonces('obtiene un mensaje de error por plan inexistente') do
  expect(@response_afiliado.status).to eq 400
  expect(@response_afiliado.body).to eq 'El plan es inexistente'
end
