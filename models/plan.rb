class Plan
  attr_accessor :id, :nombre, :costo, :limite_cobertura_visitas, :cantidad_copago

  def initialize(nombre, costo, limite_cobertura_visitas, cantidad_copago)
    @nombre = nombre
    @costo = costo
    @limite_cobertura_visitas = limite_cobertura_visitas
    @cantidad_copago = cantidad_copago
  end
end
