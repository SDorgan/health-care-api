require_relative './plan_argumentos_invalidos'

class PlanSinCopagoError < PlanArgumentosInvalidosError
  def initialize(msg = 'no se especifica el valor del copago')
    super
  end
end
