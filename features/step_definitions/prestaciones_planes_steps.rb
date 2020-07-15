Dado('el plan llamado {string}') do |nombre_plan|
  # should look up the plan_id here
end

Cuando('se le agrega la prestación {string}') do |string|
  request = {
    'prestacion': string
  }
  URL = "#{PLANES_URL}/#{@plan_id}/prestaciones".freeze

  @response = Faraday.post(URL, request.to_json, 'Content-Type' => 'application/json')
end

Entonces('se actualiza el plan exitosamente') do
  URL = "#{PLANES_URL}/#{@plan_id}/prestaciones".freeze
  @response = Faraday.get(URL)

  json_response = JSON.parse(@response.body)
  prestaciones = json_response['prestaciones']

  nombres = prestaciones.map { |prestacion| prestacion['nombre'] }

  expect(nombres.include?(@nombre_prestacion)).to eq true
end
