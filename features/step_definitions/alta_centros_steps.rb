Dado('el centro con nombre {string}') do |nombre_centro|
  @request = {
    'nombre': nombre_centro
  }
  @nombre_centro = nombre_centro
end

Dado('coordenadas geográficas latitud {string} y longitud {string}') do |_lat, _long|
end

Cuando('se registra el centro') do
  @response = Faraday.post(CENTROS_URL, @request.to_json, 'Content-Type' => 'application/json')
  json_response = JSON.parse(@response.body)
  centro = json_response['centro']

  @centros = {} if @centros.nil?
  @centros[@nombre_centro] = centro['id']
end
