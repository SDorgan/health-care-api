class CoordenadasInvalidasError < StandardError
  def initialize(msg = 'No se pasó un par válido de coordenadas')
    super
  end
end
