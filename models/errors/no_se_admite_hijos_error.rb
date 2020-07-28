require_relative 'registracion_error'

class NoSeAdmiteHijosError < RegistracionError
  def initialize(msg = 'este plan no admite hijos')
    super
  end
end
