class Prestacion
  attr_accessor :id, :nombre, :slug, :costo, :centros

  def initialize(nombre, costo)
    @nombre = nombre
    @costo = costo
    @slug = sluggify(nombre)
  end

  private

  def sluggify(string)
    string.downcase.tr('àáäâãèéëẽêìíïîĩòóöôõùúüûũñç ', 'aaaaaeeeeeiiiiiooooouuuuunc_')
  end
end
