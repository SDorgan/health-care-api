class CalculadorDistancia
  def obtener_direcciones_a_punto(centros, latitud, longitud)
    body = armar_body(centros, latitud, longitud)
    response = llamar_api(body)
    parsear_resultado(response)
  end

  private

  EXTERNAL_DISTANCE_URL = "http://www.mapquestapi.com/directions/v2/routematrix?key=#{ENV['DISTANCE_KEY']}".freeze # rubocop:disable Metrics/LineLength
  MILE_TO_KM = 1.60934

  def armar_body(centros, latitud, longitud)
    locations = []
    locations << { 'latLng' => { 'lat' => latitud, "lng": longitud } }
    locations += armar_coordenadas_de_centros(centros)

    { 'locations' => locations }.to_json
  end

  def armar_coordenadas_de_centros(centros)
    result = []
    centros.each do |centro|
      result << { 'latLng' => { 'lat' => centro.latitud, "lng": centro.longitud } }
    end

    result
  end

  def llamar_api(body)
    Faraday.post(EXTERNAL_DISTANCE_URL, body, 'Content-Type' => 'application/json')
  end

  def parsear_resultado(response)
    return ApiExternaError unless response.status == 200

    json_response = JSON.parse(response.body)

    return ApiExternaError unless json_response['info']['statuscode'].zero?

    distancias = json_response['distance'][1..-1]
    locations = json_response['locations'][1..-1]

    armar_resultado(distancias, locations)
  end

  def armar_resultado(distancias, locations)
    distancias_out = []
    distancias.each do |distancia|
      distancias_out << distancia * MILE_TO_KM
    end

    direcciones = []

    locations.each do |location|
      direcciones << location['street']
    end

    { distancias: distancias_out, direcciones: direcciones }
  end
end
