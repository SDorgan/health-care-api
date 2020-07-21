class VisitaMedica
  attr_accessor :id, :created_on, :afiliado_id, :prestacion, :costo

  def initialize(afiliado_id, prestacion)
    @afiliado_id = afiliado_id
    @prestacion = prestacion
  end
end
