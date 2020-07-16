Cuando('consulta el resumen') do
  response = Faraday.get(RESUMEN_URL + "?id=#{@id_afiliado}&from=api")
  json_response = JSON.parse(response.body)

  @resumen = json_response['resumen']
end

Entonces('su saldo adicional es ${int}') do |saldo|
  expect(@resumen['adicional']).to eq saldo
end

Dado('total a pagar es ${int}') do |total|
  expect(@resumen['total']).to eq total
end

Dado('que registró una atención por la prestación {string}') do |prestacion_nombre|
  request = {
    'afiliado' => @id_afiliado,
    'prestacion' => prestacion_nombre
  }
  @response = Faraday.post(VISITAS_URL, request.to_json, 'Content-Type' => 'application/json')
end
