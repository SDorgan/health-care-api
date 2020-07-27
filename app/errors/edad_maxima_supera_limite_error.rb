class EdadMaximaSuperaLimiteError < StandardError
  def initialize(msg = 'supera el límite máximo de edad')
    super
  end
end
