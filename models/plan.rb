class Plan
  attr_accessor :id, :nombre, :costo

  def initialize(nombre, costo)
    @nombre = nombre
    @costo = costo
  end
end
