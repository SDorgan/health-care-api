require_relative './plan_argumentos_invalidos'

class PlanCopagoInvalido < PlanArgumentosInvalidosError
  def initialize(msg = 'valor del copago invalido: debe ser un numero positivo')
    super
  end
end
