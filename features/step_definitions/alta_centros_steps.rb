Dado('el centro con nombre {string}') do |nombre_centro|
  @request = {
    'nombre': nombre_centro
  }
end

Cuando('se registra el centro') do
  @response = Faraday.post(CENTROS_URL, @request.to_json, 'Content-Type' => 'application/json')
end
