require_relative '../lib/string_helper'

class Prestacion
  attr_accessor :id, :nombre, :slug, :costo, :centros

  def initialize(nombre, costo)
    raise PrestacionSinCostoError if costo.nil?
    raise PrestacionCostoNegativoError if costo.negative?

    @nombre = nombre
    @costo = costo
    @slug = StringHelper.sluggify(nombre)
  end
end
