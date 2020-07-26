class ItemResumen
  attr_accessor :nombre, :fecha, :costo

  def initialize(nombre, fecha, costo)
    @nombre = nombre
    @fecha = fecha
    @costo = costo
  end
end
