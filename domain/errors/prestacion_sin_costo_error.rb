require_relative './prestacion_costo_invalido'

class PrestacionSinCostoError < PrestacionCostoInvalido
  def initialize(msg = 'se debe especificar un costo')
    super
  end
end
