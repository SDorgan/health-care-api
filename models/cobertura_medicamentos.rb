class CoberturaMedicamentos
  attr_accessor :porcentaje

  def initialize(porcentaje)
    @porcentaje = porcentaje
  end

  def aplicar(compras)
    compras
  end
end
