class Plan
  attr_accessor :id, :nombre, :costo,
                :cobertura_visitas, :cobertura_medicamentos, :edad_minima,
                :edad_maxima

  def initialize(data = {})
    @nombre = data[:nombre]
    @costo = data[:costo]
    @cobertura_visitas = data[:cobertura_visitas]
    @cobertura_medicamentos = data[:cobertura_medicamentos]
    @edad_minima = data[:edad_minima]
    @edad_maxima = data[:edad_maxima]
  end
end
