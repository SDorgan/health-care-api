class Centro
  include ActiveModel::Validations

  attr_accessor :id, :nombre, :latitud, :longitud, :prestaciones

  validates :latitud, :longitud, presence: true

  def initialize(nombre, latitud, longitud)
    @nombre = nombre
    @latitud = latitud
    @longitud = longitud
  end
end
