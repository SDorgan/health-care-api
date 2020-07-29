class PlanSinNombreError < StandardError
  def initialize(msg = 'se debe especificar un nombre')
    super
  end
end
