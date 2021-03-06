class PrestacionResponseBuilder
  def self.create_from(prestacion)
    {
      'prestacion': {
        'id': prestacion.id,
        'nombre': prestacion.nombre,
        'costo': prestacion.costo
      }
    }.to_json
  end

  def self.create_from_all(prestaciones)
    output = { 'prestaciones': [] }
    prestaciones.each do |prestacion|
      output[:prestaciones] << {
        'id': prestacion.id,
        'nombre': prestacion.nombre,
        'costo': prestacion.costo
      }
    end

    output.to_json
  end
end
