class VisitaMedica
  attr_accessor :id, :created_on, :afiliado_id, :prestacion, :centro, :costo

  def initialize(afiliado_id, prestacion, centro)
    @afiliado_id = afiliado_id
    @prestacion = prestacion
    @centro = centro
  end
end
