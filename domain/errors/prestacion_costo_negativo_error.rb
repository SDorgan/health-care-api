require_relative './prestacion_costo_invalido'

class PrestacionCostoNegativoError < PrestacionCostoInvalido
  def initialize(msg = 'se debe especificar un costo positivo')
    super
  end
end
