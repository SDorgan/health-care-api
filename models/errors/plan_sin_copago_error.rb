class PlanSinCopagoError < PlanArgumentosInvalidosError
  def initialize(msg = 'no se especifica el valor del copago')
    super
  end
end
