require_relative './plan_argumentos_invalidos'

class PlanCoberturaMedicamentosInvalida < PlanArgumentosInvalidosError
  def initialize(msg = 'el valor de la cobertura de medicamentos debe ser positivo')
    super
  end
end
