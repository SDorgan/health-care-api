class CoberturaVisita
  attr_accessor :cantidad, :copago

  def initialize(cantidad, copago)
    @cantidad = cantidad
    @copago = copago
  end

  def aplicar(visitas)
    visitas.each_with_index.map do |visita, num|
      visita.costo = 0
      visita.costo = visita.prestacion.costo if num >= @cantidad

      visita
    end
  end
end
