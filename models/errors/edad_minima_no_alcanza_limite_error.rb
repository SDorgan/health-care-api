require_relative 'registracion_error'

class EdadMinimaNoAlcanzaLimiteError < RegistracionError
  def initialize(msg = 'no alcanza el límite mínimo de edad')
    super
  end
end
