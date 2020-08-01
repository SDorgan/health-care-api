class PlanSinCoberturaMedicamentosError < PlanArgumentosInvalidosError
  def initialize(msg = 'no se especifica la cobertura de medicamentos')
    super
  end
end
