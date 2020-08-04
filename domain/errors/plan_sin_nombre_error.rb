require_relative './plan_argumentos_invalidos'

class PlanSinNombreError < PlanArgumentosInvalidosError
  def initialize(msg = 'se debe especificar un nombre')
    super
  end
end
