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

Dado('el plan con nombre {string} con costo unitario ${int}') do |nombre_plan, costo|
  @request = {
    'nombre' => nombre_plan,
    'costo' => costo
  }
end

Cuando('se registra el plan') do
  @response = Faraday.post(PLANES_URL, @request.to_json, 'Content-Type' => 'application/json')
  json_response = JSON.parse(@response.body)
  plan = json_response['plan']
  @plan_id = plan['id']
end

Entonces('se registra exitosamente') do
  expect(@response.status).to eq 201
end

Dado('cobertura de visitas con límite {int}') do |limite_visitas|
  @request = {
    'nombre' => @request['nombre'],
    'costo' => @request['costo'],
    'limite_cobertura_visitas' => limite_visitas
  }
end
