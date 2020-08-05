Cuando('consulto por centros cercanos a latitud {string} y longitud {string}') do |latitud, longitud| # rubocop:disable Metrics/LineLength
  URL = "#{CENTROS_URL}?latitud=#{ERB::Util.url_encode(latitud)}&longitud=#{ERB::Util.url_encode(longitud)}".freeze # rubocop:disable Metrics/LineLength
  @response = Faraday.get(URL, {}, 'HTTP_API_KEY' => API_KEY)
end

Entonces('el centro más cercano es el {string}') do |centro|
  json_response = JSON.parse(@response.body)

  expect(@response.status).to be 200
  expect(json_response['centro']).to eq centro
end
