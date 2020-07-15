class PrestacionDeCentro
  attr_accessor :id, :centro_id, :prestacion_id

  def initialize(centro, prestacion)
    @centro_id = centro.id
    @prestacion_id = prestacion.id
  end
end
