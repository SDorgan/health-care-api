class ItemResumen
  attr_accessor :concepto, :fecha, :costo

  def initialize(concepto, fecha, costo)
    @concepto = concepto
    @fecha = fecha
    @costo = costo
  end
end
