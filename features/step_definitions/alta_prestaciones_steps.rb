Dado('la prestación con nombre {string}') do |nombre|
  @nombre_prestacion = nombre
end

Dado('costo unitario de prestación ${int}') do |costo|
  @costo_prestacion = costo
end

Cuando('se registra la prestación') do
  @request = {
    'nombre': @nombre_prestacion,
    'costo': @costo_prestacion
  }

  @response = Faraday.post(PRESTACIONES_URL, @request.to_json, 'Content-Type' => 'application/json')

  json_response = JSON.parse(@response.body)
  mi_prestacion = json_response['prestacion']

  @prestaciones = {} if @prestaciones.nil?
  @prestaciones[@nombre_prestacion] = mi_prestacion['id']
end

Entonces('la prestación se registra exitosamente') do
  json_response = JSON.parse(@response.body)

  mi_prestacion = json_response['prestacion']

  expect(mi_prestacion['nombre']).to eq 'Traumatología'
  expect(mi_prestacion['costo']).to eq 1200
end
