class PrestacionCostoDebeSerNumericoError < PrestacionCostoInvalido
  def initialize(msg = 'se debe especificar un costo numerico positivo')
    super
  end
end
