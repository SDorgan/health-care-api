class CompraMedicamentos
  attr_accessor :id, :fecha_compra, :afiliado_id, :monto, :costo_final

  def initialize(afiliado_id, monto, fecha = DateManager.date)
    @afiliado_id = afiliado_id
    @monto = monto
    @fecha_compra = fecha
  end
end
