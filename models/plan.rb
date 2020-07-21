class Plan
  attr_accessor :id, :nombre, :costo,
                :cobertura_visitas, :copago, :cobertura_medicamentos

  def initialize(nombre, costo, copago,
                 cobertura_medicamentos, cobertura_visitas)
    @nombre = nombre
    @costo = costo
    @cobertura_visitas = cobertura_visitas
    @copago = copago
    @cobertura_medicamentos = cobertura_medicamentos
  end
end
