class PrestacionCostoNegativoError < StandardError
  def initialize(msg = 'se debe especificar un costo positivo')
    super
  end
end
