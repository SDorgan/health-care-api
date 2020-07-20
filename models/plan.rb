class Plan
  attr_accessor :id, :nombre, :costo,
                :limite_cobertura_visitas, :copago, :cobertura_medicamentos

  def initialize(nombre, costo, limite_cobertura_visitas,
                 copago, cobertura_medicamentos = 0)
    @nombre = nombre
    @costo = costo
    @limite_cobertura_visitas = limite_cobertura_visitas
    @copago = copago
    @cobertura_medicamentos = cobertura_medicamentos
  end
end
