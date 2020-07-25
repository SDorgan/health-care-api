class CompraMedicamentos
  attr_accessor :id, :created_on, :afiliado_id, :monto, :costo_final

  def initialize(afiliado_id, monto)
    @afiliado_id = afiliado_id
    @monto = monto
  end
end
