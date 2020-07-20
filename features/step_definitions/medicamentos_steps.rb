Cuando('realiza una compra de medicamentos por ${int}') do |monto|
  request = {
    'afiliado' => @id_afiliado,
    'monto' => monto
  }
  @response = Faraday.post(MEDICAMENTOS_URL, request.to_json, 'Content-Type' => 'application/json')
end

Entonces('se registra la compra con un identificador único') do
  json_response = JSON.parse(@response.body)
  compra = json_response['compra']
  status = @response.status

  expect(status).to eq 201
  expect(compra['id'].positive?).to eq true
end
