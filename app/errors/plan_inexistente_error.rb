class PlanInexistenteError < StandardError
  def initialize(msg = 'El plan es inexistente')
    super
  end
end
