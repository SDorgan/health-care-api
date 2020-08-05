Dado('el centro con nombre {string}') do |nombre_centro|
  @request = {
    'nombre': nombre_centro
  }
  @nombre_centro = nombre_centro
end

Cuando('se registra el centro') do
  @response = Faraday.post(CENTROS_URL, @request.to_json, 'Content-Type' => 'application/json', 'HTTP_API_KEY' => API_KEY)
  if @response.successful?
    json_response = JSON.parse(@response.body)
    centro = json_response['centro']

    @centros = {} if @centros.nil?
    @centros[@nombre_centro] = centro['id']
  end
end

Dado('coordenadas geográficas latitud {string} y longitud {string}') do |lat, long|
  @request = {
    'nombre': @nombre_centro,
    'latitud': lat.to_f,
    'longitud': long.to_f
  }
  @coords_centros = [] if @centros.nil?
  @coords_centros << { 'latitud': lat.to_f, 'longitud': long.to_f }
end

Entonces('se obtiene un mensaje de error por falta de coordenadas') do
  expect(@response.status).to eq 400
  expect(@response.body).to eq 'No se pasó un par válido de coordenadas'
end

Entonces('se obtiene un mensaje de error centro ya existente') do
  expect(@response.status).to eq 400
  expect(@response.body).to eq 'El centro ingresado ya existe'
end
