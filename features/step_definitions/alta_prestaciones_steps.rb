require 'byebug'
Dado('la prestación con nombre {string}') do |string|
  @nombre = string
end

Dado('costo unitario de prestación ${int}') do |int|
  @costo = int
end

Cuando('se registra la prestación') do
  @request = {
    'nombre': @nombre,
    'costo': @costo
  }

  @response = Faraday.post(PRESTACIONES_URL, @request.to_json, 'Content-Type' => 'application/json')
end

Entonces('la prestación se registra exitosamente') do
  json_response = JSON.parse(@response.body)

  mi_prestacion = json_response['prestacion']

  expect(mi_prestacion['nombre']).to eq 'Traumatología'
  expect(mi_prestacion['costo']).to eq 1200
end
