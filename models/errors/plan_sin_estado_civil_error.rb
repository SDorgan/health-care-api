class PlanSinEstadoCivilError < PlanArgumentosInvalidosError
  def initialize(msg = 'no se especifica el estado civil requerido por el afiliado')
    super
  end
end
