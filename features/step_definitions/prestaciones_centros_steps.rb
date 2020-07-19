Dado('el centro llamado {string}') do |nombre|
  @response = Faraday.get(CENTROS_URL)
  json_response = JSON.parse(@response.body)

  centros = json_response['centros']
  centro = centros.find { |item| item['nombre'].eql?(nombre) }

  @centro_id = centro['id']
end

Cuando('se le agrega la prestación {string} al centro') do |nombre_prestacion|
  prestacion = PrestacionRepository.new.find_by_name(nombre_prestacion)
  request = {
    'prestacion': prestacion.id
  }
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
