Cuando('se atiende por {string} en el centro {string}') do |prestacion_nombre, _centro_nombre|
  request = {
    'afiliado' => @id_afiliado,
    'prestacion' => prestacion_nombre
  }
  @response = Faraday.post(VISITAS_URL, request.to_json, 'Content-Type' => 'application/json')
end

Entonces('se registra la prestación con un identificador único') do
  json_response = JSON.parse(@response.body)
  visita = json_response['visita']

  expect(visita['id'].positive?).to eq true
end
