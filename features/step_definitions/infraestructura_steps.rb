Dado('que existe un plan') do
  precio_que_no_importa = 10
  @request = {
    'nombre': 'Plan Test',
    'costo': precio_que_no_importa,
    'limite_cobertura_visitas': 2,
    'copago': 10,
    'cobertura_medicamentos': 20,
    'edad_minima': 10,
    'edad_maxima': 30,
    'cantidad_hijos_maxima': 1,
    'conyuge' => 'ADMITE_CONYUGE'
  }

  @response = Faraday.post(PLANES_URL, @request.to_json, 'Content-Type' => 'application/json', 'HTTP_API_KEY' => API_KEY)
end

Dado('que existe una prestacion') do
  costo_que_no_importa = 10
  @request = {
    'nombre': 'Prestacion Test',
    'costo': costo_que_no_importa
  }

  @response = Faraday.post(PRESTACIONES_URL, @request.to_json, 'Content-Type' => 'application/json')
end

Dado('que existe un centro') do
  @request = {
    'nombre': 'Centro Test',
    'longitud': 10.0,
    'latitud': 10.0
  }

  @response = Faraday.post(CENTROS_URL, @request.to_json, 'Content-Type' => 'application/json')
end

Cuando("se ejecuta POST \/reset") do
  @response = Faraday.post(RESET_URL)
end

Entonces('se eliminan los datos') do
  response = Faraday.get(PLANES_URL, {}, 'Content-Type' => 'application/json', 'HTTP_API_KEY' => API_KEY)
  json_response = JSON.parse(response.body)
  planes = json_response['planes']

  response = Faraday.get(PRESTACIONES_URL, 'Content-Type' => 'application/json')
  json_response = JSON.parse(response.body)
  prestaciones = json_response['prestaciones']

  response = Faraday.get(CENTROS_URL, 'Content-Type' => 'application/json')
  json_response = JSON.parse(response.body)
  centros = json_response['centros']

  expect(planes.empty?).to be true
  expect(centros.empty?).to be true
  expect(prestaciones.empty?).to be true
end

Dado('que se esta en el ambiente de producción') do
  ENV['RACK_ENV'] = 'production'
end

Entonces('se obtiene un error') do
  expect(@response.status).to eq 405
end

Cuando("se ejecuta GET \/version") do
  @response = Faraday.get(VERSION_URL)
end

Entonces('obtiene una version semántica de {int} números') do |numeros|
  response = JSON.parse(@response.body)
  version_split = response['version'].split('.')
  expect(version_split.length).to eq numeros
end
