require_relative 'registracion_error'

class SeRequiereConyugeError < RegistracionError
  def initialize(msg = 'este plan requiere conyuge')
    super
  end
end
