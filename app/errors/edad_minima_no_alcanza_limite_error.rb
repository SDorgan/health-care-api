class EdadMinimaNoAlcanzaLimiteError < StandardError
  def initialize(msg = 'no alcanza el límite mínimo de edad')
    super
  end
end
