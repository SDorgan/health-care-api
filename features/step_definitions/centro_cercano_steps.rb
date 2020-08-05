require 'webmock'
Cuando('consulto por centros cercanos a latitud {string} y longitud {string}') do |latitud, longitud| # rubocop:disable Metrics/LineLength
  URL = "#{CENTROS_URL}?latitud=#{latitud}&longitud=#{longitud}".freeze

  stub_nearest_location(latitud, longitud, @coords_centros)
  @response = Faraday.get(URL, {}, 'HTTP_API_KEY' => API_KEY)
end

Entonces('el centro más cercano es el {string}') do |centro|
  json_response = JSON.parse(@response.body)

  expect(@response.status).to be 200
  cercano = json_response['centros'].first
  expect(cercano['nombre']).to eq centro
end
