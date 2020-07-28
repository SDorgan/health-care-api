class Prestacion
  attr_accessor :id, :nombre, :costo, :centros

  def initialize(nombre, costo)
    @nombre = nombre
    @costo = costo
  end
end
