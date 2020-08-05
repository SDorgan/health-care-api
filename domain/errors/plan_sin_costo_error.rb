require_relative './plan_argumentos_invalidos'

class PlanSinCostoError < PlanArgumentosInvalidosError
  def initialize(msg = 'se debe especificar un costo')
    super
  end
end
