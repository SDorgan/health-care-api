class Centro
  attr_accessor :id, :nombre, :latitud, :longitud, :prestaciones

  def initialize(nombre, latitud = nil, longitud = nil)
    @nombre = nombre
    @latitud = latitud
    @longitud = longitud
  end
end
