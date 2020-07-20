class Plan
  attr_accessor :id, :nombre, :costo, :limite_cobertura_visitas, :copago

  def initialize(nombre, costo, limite_cobertura_visitas, copago)
    @nombre = nombre
    @costo = costo
    @limite_cobertura_visitas = limite_cobertura_visitas
    @copago = copago
  end
end
