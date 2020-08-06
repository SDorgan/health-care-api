class CalculadorDistanciaFactory
  def self.obtener_calculador
    return CalculadorDistancia.new unless ENV['RACK_ENV'] == 'test'

    CalculadorDistanciaMock.new
  end
end
