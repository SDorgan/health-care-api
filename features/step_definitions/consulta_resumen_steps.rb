Cuando('consulta el resumen') do
  response = Faraday.get(RESUMEN_URL + "?id=#{@id_afiliado_telegram}", {}, 'HTTP_API_KEY' => API_KEY)
  @response_status = response.status

  if response.status == 200
    json_response = JSON.parse(response.body)
    @resumen = json_response['resumen']
  else
    @resumen = response.body
  end
end

Entonces('su saldo adicional es ${int}') do |saldo|
  expect(@resumen['adicional']).to eq saldo
end

Dado('total a pagar es ${int}') do |total|
  expect(@resumen['total']).to eq total
end

Dado('que registró una atención por la prestación {string} en el centro {string}') do |prestacion_nombre, centro_nombre| # rubocop:disable Metrics/LineLength
  request = {
    'afiliado' => @id_afiliado,
    'prestacion' => @prestaciones[prestacion_nombre],
    'centro' => @centros[centro_nombre]
  }
  @response = Faraday.post(VISITAS_URL, request.to_json, 'Content-Type' => 'application/json')
end

Entonces('obtiene un error') do
  expect(@response_status).to eq 401
  expect(@resumen).to eq 'El ID no pertenece a un afiliado'
end

Entonces('posee una visita por la prestación {string} con costo ${int}') do |nombre, precio|
  items = @resumen['items']
  contains_item = items.any? { |item| (item['concepto'].include?(nombre) && item['costo'] == precio) } # rubocop:disable  Metrics/LineLength
  expect(contains_item).to be true
end

Entonces('posee una compra de medicamentos con costo ${int}') do |precio|
  items = @resumen['items']
  contains_item = items.any? { |item| (item['concepto'].include?('Medicamentos') && item['costo'] == precio) } # rubocop:disable  Metrics/LineLength
  expect(contains_item).to be true
end
