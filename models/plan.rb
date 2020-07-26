class Plan
  attr_accessor :id, :nombre, :costo,
                :cobertura_visitas, :cobertura_medicamentos, :edad_minima

  def initialize(nombre, costo, cobertura_medicamentos, cobertura_visitas, edad_minima)
    @nombre = nombre
    @costo = costo
    @cobertura_visitas = cobertura_visitas
    @cobertura_medicamentos = cobertura_medicamentos
    @edad_minima = edad_minima
  end
end
