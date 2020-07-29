class CoberturaVisita
  attr_accessor :cantidad, :copago

  def initialize(cantidad, copago)
    raise PlanSinCopagoError if copago.nil?

    @cantidad = cantidad
    @copago = copago
  end

  def aplicar(visitas)
    visitas.each_with_index.map do |visita, num|
      visita.costo = if num >= @cantidad
                       visita.prestacion.costo
                     else
                       @copago
                     end

      visita
    end
  end
end
