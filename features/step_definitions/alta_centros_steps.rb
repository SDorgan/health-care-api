Dado('el centro con nombre {string}') do |nombre_centro|
  @request = {
    'nombre': nombre_centro
  }
end

Cuando('se registra el centro') do
  @response = Faraday.post(CENTROS_URL, @request.to_json, 'Content-Type' => 'application/json')
  json_response = JSON.parse(@response.body)
  centro = json_response['centro']
  @centro_id = centro['id']
end
