class ApiExternaError < StandardError
  def initialize(msg = 'Error con la API externa')
    super
  end
end
