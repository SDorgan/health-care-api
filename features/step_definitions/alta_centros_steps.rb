Dado('el centro con nombre {string}') do |nombre_centro|
  @request = {
    'nombre': nombre_centro
  }
  @nombre_centro = nombre_centro
end

Cuando('se registra el centro') do
  @response = Faraday.post(CENTROS_URL, @request.to_json, 'Content-Type' => 'application/json')
  json_response = JSON.parse(@response.body)
  centro = json_response['centro']

  @centros = {} if @centros.nil?
  @centros[@nombre_centro] = centro['id']
end

Dado('coordenadas geográficas latitud {string} y longitud {string}') do |lat, long|
  @request = {
    'nombre': @nombre_centro,
    'latitud': lat.to_f,
    'longitud': long.to_f
  }
end

Entonces('se obtiene un mensaje de error por falta de coordenadas') do
  expect(response_status).to eq 400
  expect(@response.body).to eq 'La prestación pedida no existe'
end

Entonces('se obtiene un mensaje de error centro ya existente') do
  pending # Write code here that turns the phrase above into concrete actions
end
