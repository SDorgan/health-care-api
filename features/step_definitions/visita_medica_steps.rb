Cuando('se atiende por {string} en el centro {string}') do |prestacion_nombre, _centro_nombre|
  request = {
    'afiliado' => @id_afiliado,
    'prestacion' => @prestaciones[prestacion_nombre]
  }
  @response = Faraday.post(VISITAS_URL, request.to_json, 'Content-Type' => 'application/json')
end

Entonces('se registra la prestación con un identificador único') do
  json_response = JSON.parse(@response.body)
  visita = json_response['visita']

  expect(visita['id'].positive?).to eq true
end

Entonces('obtiene un error por no estar afiliado') do
  expect(@response_status).to eq 401
  expect(@resumen).to eq 'El ID no pertenece a un afiliado'
end

Entonces('obtiene un error por prestación no existente') do
  expect(@response_status).to eq 404
  expect(@resumen).to eq 'La prestación pedida no existe'
end

Entonces('obtiene un error por centro no existen') do
  expect(@response_status).to eq 404
  expect(@resumen).to eq 'El centro pedido no existe'
end

Entonces('obtiene un error por prestacion no ofrecida en el centro') do
  expect(@response_status).to eq 404
  expect(@resumen).to eq 'La prestación pedida no se ofrece en el centro'
end
