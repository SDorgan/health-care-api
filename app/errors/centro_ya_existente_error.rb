class CentroYaExistenteError < StandardError
  def initialize(msg = 'El centro ingresado ya existe')
    super
  end
end
