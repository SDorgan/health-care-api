Dado('que existe un plan') do
  @request = {
    'nombre': 'Plan Test'
  }

  @response = Faraday.post(PLANES_URL, @request.to_json, 'Content-Type' => 'application/json')
end

Cuando("se ejecuta POST \/reset") do
  @response = Faraday.post(RESET_URL)
end

Entonces('se eliminan los datos') do
  response = Faraday.get(PLANES_URL, 'Content-Type' => 'application/json')

  json_response = JSON.parse(response.body)
  planes = json_response['planes']
  expect(planes.empty?).to eq true
end

Dado('que se esta en el ambiente de producción') do
  ENV['RACK_ENV'] = 'production'
end

Entonces('se obtiene un error') do
  expect(@response.status).to eq 405
end
