class PrestacionCostoNegativoError < PrestacionCostoInvalido
  def initialize(msg = 'se debe especificar un costo positivo')
    super
  end
end
