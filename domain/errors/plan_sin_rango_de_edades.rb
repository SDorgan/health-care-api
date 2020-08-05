require_relative './plan_argumentos_invalidos'

class PlanSinRangoDeEdadesError < PlanArgumentosInvalidosError
  def initialize(msg = 'rango de edades no especificado correctamente')
    super
  end
end
