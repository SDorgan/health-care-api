class CoberturaVisitaInfinita
  LIMITE = 1000

  attr_accessor :cantidad

  def initialize
    @cantidad = LIMITE
  end

  def filtrar(_visitas)
    []
  end
end
