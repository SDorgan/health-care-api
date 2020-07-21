class CoberturaVisita
  attr_accessor :cantidad

  def initialize(cantidad)
    @cantidad = cantidad
  end

  def filtrar(visitas)
    visitas.drop(@cantidad)
  end
end
