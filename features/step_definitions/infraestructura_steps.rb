Dado('que existe un plan') do
  precio_que_no_importa = 10
  @request = {
    'nombre': 'Plan Test',
    'precio': precio_que_no_importa
  }

  @response = Faraday.post(PLANES_URL, @request.to_json, 'Content-Type' => 'application/json')
end

Dado('que existe una prestacion') do
  costo_que_no_importa = 10
  @request = {
    'nombre': 'Prestacion Test',
    'costo': costo_que_no_importa
  }

  @response = Faraday.post(PRESTACIONES_URL, @request.to_json, 'Content-Type' => 'application/json')
end

Cuando("se ejecuta POST \/reset") do
  @response = Faraday.post(RESET_URL)
end

Entonces('se eliminan los datos') do
  response = Faraday.get(PLANES_URL, 'Content-Type' => 'application/json')
  json_response = JSON.parse(response.body)
  planes = json_response['planes']

  response = Faraday.get(PRESTACIONES_URL, 'Content-Type' => 'application/json')
  json_response = JSON.parse(response.body)
  prestaciones = json_response['prestaciones']

  expect(planes.empty?).to be true
  expect(prestaciones.empty?).to be true
end

Dado('que se esta en el ambiente de producción') do
  ENV['RACK_ENV'] = 'production'
end

Entonces('se obtiene un error') do
  expect(@response.status).to eq 405
end
