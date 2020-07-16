class VisitaMedica
  attr_accessor :afiliado_id, :prestacion_id

  def initialize(afiliado_id, prestacion)
    @afiliado_id = afiliado_id
    @prestacion_id = prestacion.id
  end
end
