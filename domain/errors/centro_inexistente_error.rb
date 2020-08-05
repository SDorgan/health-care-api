class CentroInexistenteError < StandardError
  def initialize(msg = 'El centro pedido no existe')
    super
  end
end
