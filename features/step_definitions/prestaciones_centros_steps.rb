Dado('el centro llamado {string}') do |nombre|
  @response = Faraday.get(CENTROS_URL)
  json_response = JSON.parse(@response.body)

  centros = json_response['centros']
  centro = centros.find { |item| item['nombre'].eql?(nombre) }

  @centro_id = centro['id']
end

Dado('el centro inexistente llamado {string}') do |nombre|
  fake_id = 999_999_999
  @centro_id = fake_id
  @centros[nombre] = @centro_id
end

Cuando('se le agrega la prestación {string} al centro {string}') do |nombre_prestacion, nombre_centro| # rubocop:disable Metrics/LineLength
  prestacion = PrestacionRepository.new.find_by_name(nombre_prestacion)
  request = {
    'prestacion': prestacion.id
  }
  @centro_id = @centros[nombre_centro]

  URL = "#{CENTROS_URL}/#{@centro_id}/prestaciones".freeze

  @response = Faraday.post(URL, request.to_json, 'Content-Type' => 'application/json')
end

Cuando('se le agrega la prestación inexistente {string} al centro {string}') do |_nombre_prestacion, nombre_centro| # rubocop:disable Metrics/LineLength
  fake_id = 999_999_999
  request = {
    'prestacion': fake_id
  }
  @centro_id = @centros[nombre_centro]

  URL = "#{CENTROS_URL}/#{@centro_id}/prestaciones".freeze

  @response = Faraday.post(URL, request.to_json, 'Content-Type' => 'application/json')
end

Entonces('se actualiza el centro exitosamente') do
  URL = "#{CENTROS_URL}/#{@centro_id}/prestaciones".freeze
  @response = Faraday.get(URL)

  json_response = JSON.parse(@response.body)
  prestaciones = json_response['prestaciones']

  nombres = prestaciones.map { |prestacion| prestacion['nombre'] }

  expect(nombres.include?(@nombre_prestacion)).to eq true
end

Entonces('se obtiene un error por prestación repetida') do
  expect(@response.status).to eq 400
  expect(@response.body).to eq 'El centro ya presenta esa prestación'
end
