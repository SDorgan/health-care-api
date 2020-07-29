class PlanSinCantidadMaximaHijosError < PlanArgumentosInvalidosError
  def initialize(msg = 'no se especifica la cantidad de hijos máxima')
    super
  end
end
