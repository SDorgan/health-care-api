Dado('el plan con nombre {string} con costo unitario ${int}') do |string, int|
  @plan_data = { 'nombre' => string,
                 'costo' => int }
end

Dado('se registra el plan') do
  @request = {
    'nombre': @plan_data['nombre'],
    'costo': @plan_data['costo']
  }

  Faraday.post(PLANES_URL, @request.to_json, 'Content-Type' => 'application/json')
end

Dado('el plan llamado {string}') do |nombre_plan|
  URL = "#{PLAN_URL}/#{nombre_plan}".freeze
  response = Faraday.get(URL)
  json_response = JSON.parse(response.body)
  plan = json_response['plan']
  @plan_id = plan['id']
end

Cuando('se le agrega la prestación {string}') do |string|
  request = {
    'prestacion': string
  }
  URL = "#{PLAN_URL}/@plan_id/prestaciones".freeze

  @response = Faraday.post(URL, request.to_json, 'Content-Type' => 'application/json')
end

Entonces('se actualiza el plan exitosamente') do
  URL = "#{PLAN_URL}/#{@plan_id}/prestaciones".freeze
  @response = Faraday.get(URL)

  json_response = JSON.parse(@response.body)
  prestaciones = json_response['prestaciones']

  nombres = prestaciones.map { |prestacion| prestacion['nombre'] }

  expect(nombres.include?(nombre_plan)).to eq @nombre_prestacion
end
