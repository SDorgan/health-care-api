class CoberturaVisitaInfinita
  LIMITE = 1000

  attr_accessor :cantidad, :copago

  def initialize(copago)
    raise PlanSinCopagoError if copago.nil?
    raise PlanCopagoInvalido if copago.negative?

    @cantidad = LIMITE
    @copago = copago
  end

  def aplicar(visitas)
    visitas.map do |visita|
      visita.costo = @copago

      visita
    end
  end
end
