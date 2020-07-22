class CoberturaMedicamentos
  PORCIENTO = 100.0

  attr_accessor :porcentaje

  def initialize(porcentaje)
    @porcentaje = porcentaje
  end

  def aplicar(compras)
    compras.map do |compra|
      costo_final = (1 - (@porcentaje / PORCIENTO)) * compra.monto
      compra.costo_final = costo_final

      compra
    end
  end
end
