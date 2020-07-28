class Centro
  include ActiveModel::Validations

  attr_accessor :id, :nombre, :slug, :latitud, :longitud, :prestaciones

  validates :latitud, :longitud, presence: true

  def initialize(nombre, latitud, longitud)
    @nombre = nombre
    @latitud = latitud
    @longitud = longitud
    @slug = sluggify(nombre)
  end

  private

  def sluggify(string)
    string.downcase.tr('àáäâãèéëẽêìíïîĩòóöôõùúüûũñç ', 'aaaaaeeeeeiiiiiooooouuuuunc_')
  end
end
