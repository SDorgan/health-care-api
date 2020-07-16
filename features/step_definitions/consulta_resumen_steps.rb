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
