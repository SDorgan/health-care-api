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
  pending # Write code here that turns the phrase above into concrete actions
end

Dado('el afiliado {string}') do |_string|
  pending # Write code here that turns the phrase above into concrete actions
end

Entonces('obtiene un error por prestación no existente') do
  pending # Write code here that turns the phrase above into concrete actions
end

Entonces('obtiene un error por centro no existen') do
  pending # Write code here that turns the phrase above into concrete actions
end

Entonces('obtiene un error por prestacion no ofrecida en el centro') do
  pending # Write code here that turns the phrase above into concrete actions
end
