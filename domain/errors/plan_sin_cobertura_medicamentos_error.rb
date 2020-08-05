require_relative './plan_argumentos_invalidos'

class PlanSinCoberturaMedicamentosError < PlanArgumentosInvalidosError
  def initialize(msg = 'no se especifica la cobertura de medicamentos')
    super
  end
end
