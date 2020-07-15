class Plan
  attr_accessor :id, :nombre, :precio

  def initialize(nombre, precio)
    @nombre = nombre
    @precio = precio
  end
end
