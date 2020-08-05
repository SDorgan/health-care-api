class AfiliadoNoEncontrado < StandardError
  def initialize(msg = 'El ID no pertenece a un afiliado')
    super(msg)
  end
end
