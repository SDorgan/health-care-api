class PlanRangoDeEdadesInvalido < PlanArgumentosInvalidosError
  def initialize(msg = 'rango de edades invalido: edad maximo supera edad minima')
    super
  end
end
