class PrestacionSinCostoError < StandardError
  def initialize(msg = 'se debe especificar un costo')
    super
  end
end
