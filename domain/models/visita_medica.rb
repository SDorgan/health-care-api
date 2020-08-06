class VisitaMedica
  attr_accessor :id, :fecha_visita, :afiliado_id, :prestacion, :centro, :costo

  def initialize(afiliado_id, prestacion, centro, fecha = DateManager.date)
    @afiliado_id = afiliado_id
    @prestacion = prestacion
    @centro = centro
    @fecha_visita = fecha
  end
end
