Dado('la prestación con nombre {string}') do |nombre|
  @nombre_prestacion = nombre
end

Dado('costo unitario de prestación ${int}') do |costo|
  @costo_prestacion = costo
end

Dado('costo unitario de prestación {string}') do |costo|
  @costo_prestacion = costo
end

Dado('la prestación con costo unitario ${int}') do |costo|
  @costo_prestacion = costo
end

Cuando('se registra la prestación') do
  @request = {
    'nombre': @nombre_prestacion,
    'costo': @costo_prestacion
  }

  @response = Faraday.post(PRESTACIONES_URL, @request.to_json, 'Content-Type' => 'application/json', 'HTTP_API_KEY' => API_KEY)

  json_response = JSON.parse(@response.body)
  mi_prestacion = json_response['prestacion']

  @prestaciones = {} if @prestaciones.nil?
  @prestaciones[@nombre_prestacion] = mi_prestacion['id']
end

Cuando('se registra la prestación invalida') do
  @request = {
    'nombre': @nombre_prestacion,
    'costo': @costo_prestacion
  }

  @response = Faraday.post(PRESTACIONES_URL, @request.to_json, 'Content-Type' => 'application/json', 'HTTP_API_KEY' => API_KEY)
end

Entonces('la prestación se registra exitosamente') do
  json_response = JSON.parse(@response.body)

  mi_prestacion = json_response['prestacion']

  expect(mi_prestacion['nombre']).to eq 'Traumatología'
  expect(mi_prestacion['costo']).to eq 1200
end

Entonces('se obtiene un mensaje de error por no indicar costo') do
  expect(@response.status).to eq 400
  json_response = JSON.parse(@response.body)
  expect(json_response['mensaje']).to eq 'se debe especificar un costo'
end

Entonces('se obtiene un mensaje de error por costo negativo') do
  expect(@response.status).to eq 400
  json_response = JSON.parse(@response.body)
  expect(json_response['mensaje']).to eq 'se debe especificar un costo positivo'
end

Entonces('se obtiene un mensaje de error de que el costo debe ser numerico') do
  expect(@response.status).to eq 400
  json_response = JSON.parse(@response.body)
  expect(json_response['mensaje']).to eq 'se debe especificar un costo numerico positivo'
end

Entonces('se obtiene un mensaje de error por no indicar el nombre') do
  expect(@response.status).to eq 400
  json_response = JSON.parse(@response.body)
  expect(json_response['mensaje']).to eq 'se debe especificar un nombre'
end
