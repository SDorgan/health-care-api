Dado('el plan con nombre {string}') do |nombre_plan|
  @request = {
    'nombre': nombre_plan
  }

  @response = Faraday.post(PLANES_URL, @request.to_json, 'Content-Type' => 'application/json')
end

Cuando('consulto los planes disponibles') do
  @response = Faraday.get(PLANES_URL, 'Content-Type' => 'application/json')
end

Entonces('obtengo el plan con nombre {string}') do |nombre_plan|
  json_response = JSON.parse(@response.body)
  planes = json_response['planes']

  nombres = planes.map { |plan| plan['nombre'] }

  expect(nombres.include?(nombre_plan)).to eq true
end
