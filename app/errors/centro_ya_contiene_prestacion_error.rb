class CentroYaContienePrestacionError < StandardError
  def initialize(msg = 'El centro ya presenta esa prestación')
    super
  end
end
