class UsuarioNoAfiliadoError < StandardError
  def initialize(msg = 'El ID no pertenece a un afiliado')
    super
  end
end
