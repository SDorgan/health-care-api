class CoberturaVisitaInfinita
  LIMITE = 1000

  attr_accessor :cantidad, :copago

  def initialize(copago)
    @cantidad = LIMITE
    @copago = copago
  end

  def aplicar(visitas)
    visitas.map do |visita|
      visita.costo = 0

      visita
    end
  end
end
