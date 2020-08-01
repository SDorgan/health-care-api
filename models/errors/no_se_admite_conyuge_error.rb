require_relative 'registracion_error'

class NoSeAdmiteConyugeError < RegistracionError
  def initialize(msg = 'este plan no admite conyuge')
    super
  end
end
