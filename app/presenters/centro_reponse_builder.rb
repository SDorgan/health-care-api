class CentroResponseBuilder
  def self.create_from(centro)
    {
      'centro': {
        'id': centro.id,
        'nombre': centro.nombre
      }
    }.to_json
  end

  def self.create_from_all(centros)
    output = { 'centros': [] }

    centros.each do |centro|
      output[:centros] << {
        'id': centro.id,
        'nombre': centro.nombre
      }
    end

    output.to_json
  end
end
