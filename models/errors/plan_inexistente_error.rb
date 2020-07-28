require_relative 'registracion_error'

class PlanInexistenteError < RegistracionError
  def initialize(msg = 'El plan es inexistente')
    super
  end
end
