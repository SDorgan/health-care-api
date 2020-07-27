require_relative 'registracion_error'

class EdadMaximaSuperaLimiteError < RegistracionError
  def initialize(msg = 'supera el límite máximo de edad')
    super
  end
end
