class CentroResponseBuilder
  def self.create_from(centro)
    {
      'centro': {
        'id': centro.id,
        'nombre': centro.nombre
      }
    }.to_json
  end
end
