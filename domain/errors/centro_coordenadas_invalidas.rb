class CentroCoordenadasInvalidas < StandardError
  def initialize(msg = 'No se pasó un par válido de coordenadas')
    super(msg)
  end
end
