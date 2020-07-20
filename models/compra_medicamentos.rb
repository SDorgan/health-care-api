class CompraMedicamentos
  attr_accessor :id, :created_on, :afiliado_id, :monto

  def initialize(afiliado_id, monto)
    @afiliado_id = afiliado_id
    @monto = monto
  end
end
