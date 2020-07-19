class Plan
  attr_accessor :id, :nombre, :costo, :limite_cobertura_visitas

  def initialize(nombre, costo, limite_cobertura_visitas)
    @nombre = nombre
    @costo = costo
    @limite_cobertura_visitas = limite_cobertura_visitas
  end
end
