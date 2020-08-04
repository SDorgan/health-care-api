require_relative '../../lib/string_helper'

class Centro
  attr_accessor :id, :nombre, :slug, :latitud, :longitud, :prestaciones

  def initialize(nombre, latitud, longitud)
    raise CentroCoordenadasInvalidas if latitud.nil? || longitud.nil?

    @nombre = nombre
    @latitud = latitud
    @longitud = longitud
    @slug = StringHelper.sluggify(nombre)
  end
end
