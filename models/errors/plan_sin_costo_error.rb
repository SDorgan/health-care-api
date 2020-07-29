class PlanSinCostoError < PlanArgumentosInvalidosError
  def initialize(msg = 'se debe especificar un costo')
    super
  end
end
