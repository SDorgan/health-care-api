require_relative '../../lib/string_helper'

class Centro
  include ActiveModel::Validations

  attr_accessor :id, :nombre, :slug, :latitud, :longitud, :prestaciones

  validates :latitud, :longitud, presence: true

  def initialize(nombre, latitud, longitud)
    @nombre = nombre
    @latitud = latitud
    @longitud = longitud
    @slug = StringHelper.sluggify(nombre)
  end
end
