class CoberturaVisitaInfinita
  LIMITE = 1000

  attr_accessor :cantidad

  def initialize
    @cantidad = LIMITE
  end

  def aplicar(visitas)
    visitas.map do |visita|
      visita.costo = 0

      visita
    end
  end
end
