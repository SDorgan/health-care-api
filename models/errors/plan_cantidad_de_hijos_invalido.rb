class PlanCantidadHijosInvalido < PlanArgumentosInvalidosError
  def initialize(msg = 'cantidad de hijos invalida: debe ser un numero positivo')
    super
  end
end
