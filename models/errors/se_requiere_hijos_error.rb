require_relative 'registracion_error'

class SeRequiereHijosError < RegistracionError
  def initialize(msg = 'este plan requiere tener hijos')
    super
  end
end
