Cuando('consulto por centros cercanos a latitud {string} y longitud {string} existiendo dos centros') do |latitud, longitud| # rubocop:disable Metrics/LineLength
  URL = "#{CENTROS_URL}?latitud=#{latitud}&longitud=#{longitud}".freeze

  body = { 'respuesta': {
    'distancias': [104.483, 107.562],
    'direcciones': ['Calle 1', 'Ruta Nacional 205']
  } }

  post '/distancias', body.to_json, 'HTTP_API_KEY' => API_KEY

  @response = Faraday.get(URL, {}, 'HTTP_API_KEY' => API_KEY)
end

Cuando('consulto por centros cercanos a latitud {string} y longitud {string} existiendo cuatro centros') do |latitud, longitud| # rubocop:disable Metrics/LineLength
  URL = "#{CENTROS_URL}?latitud=#{latitud}&longitud=#{longitud}".freeze

  body = { 'respuesta': {
    'distancias': [104.483, 107.562, 34.552, 381.492],
    'direcciones': ['Calle 1', 'Ruta Nacional 205', 'Calle 3', 'Calle 4']
  } }

  post '/distancias', body.to_json, 'HTTP_API_KEY' => API_KEY

  @response = Faraday.get(URL, {}, 'HTTP_API_KEY' => API_KEY)
end

Cuando('consulto por centros cercanos a latitud {string} y longitud {string}') do |latitud, longitud| # rubocop:disable Metrics/LineLength
  URL = "#{CENTROS_URL}?latitud=#{latitud}&longitud=#{longitud}".freeze
  @response = Faraday.get(URL, {}, 'HTTP_API_KEY' => API_KEY)
end

Entonces('el centro más cercano es el {string}') do |centro|
  json_response = JSON.parse(@response.body)

  expect(@response.status).to be 200
  cercano = json_response['centros'].first
  expect(cercano['nombre']).to eq centro
end
