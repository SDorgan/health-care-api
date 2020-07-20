Cuando('realiza una compra de medicamentos por ${int}') do |costo|
  request = {
    'afiliado' => @id_afiliado,
    'costo' => costo
  }
  @response = Faraday.post(MEDICAMENTOS_URL, request.to_json, 'Content-Type' => 'application/json')
end

Entonces('se registra la compra con un identificador único') do
  status = @response.status

  expect(status).to eq 201
end
