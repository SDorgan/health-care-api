class CentroResponseBuilder
  def self.create_from(centro)
    {
      'centro': {
        'id': centro.id,
        'nombre': centro.nombre,
        'latitud': centro.latitud,
        'longitud': centro.longitud
      }
    }.to_json
  end

  def self.create_from_all(centros)
    output = { 'centros': [] }

    centros.each do |centro|
      centro_actual = {
        'id': centro.id,
        'nombre': centro.nombre,
        'latitud': centro.latitud,
        'longitud': centro.longitud
      }
      centro_actual['direccion'] = centro.direccion unless centro.direccion.nil?
      centro_actual['distancia'] = centro.distancia unless centro.distancia.nil?

      output[:centros] << centro_actual
    end

    output.to_json
  end
end
