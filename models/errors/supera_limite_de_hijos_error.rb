require_relative 'registracion_error'

class SuperaLimiteDeHijosError < RegistracionError
  def initialize(msg = 'supera la cantidad de hijos requeridos para el plan')
    super
  end
end
