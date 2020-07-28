Dada('la prestación {string}') do |prestacion|
  @prestacion_id = @prestaciones[prestacion]
end

Cuando('realizo la consulta de centro médico') do
  URL = "#{PRESTACIONES_URL}/#{@prestacion_id}/centros".freeze
  @response = Faraday.get(URL)
end

Entonces('obtengo {string} como resultado') do |nombre_centro|
  json_response = JSON.parse(@response.body)
  centros = json_response['centros']

  nombres = centros.map { |centro| centro['nombre'] }

  expect(nombres.include?(nombre_centro)).to eq true
end

Entonces('se obtiene una respuesta vacía') do
  json_response = JSON.parse(@response.body)
  centros = json_response['centros']

  expect(centros.empty?).to eq true
end
