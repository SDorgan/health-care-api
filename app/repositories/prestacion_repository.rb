require_relative '../../lib/string_helper'
class PrestacionRepository < BaseRepository
  def initialize
    super(:prestaciones)
    @table_join_centros = :prestaciones_de_centros
  end

  def save(prestacion)
    id = insert(prestacion)

    prestacion.id = id

    prestacion
  end

  def find(id_)
    raise PrestacionNotExistsError unless exists_prestacion_with_id(id_)

    super(id_)
  end

  def full_load(id)
    prestacion = find(id)
    prestacion.centros = CentroRepository.new.find_by_prestacion(id)

    prestacion
  end

  def full_load_by_name(nombre)
    prestacion = find_by_slug(nombre)
    prestacion.centros = CentroRepository.new.find_by_prestacion(prestacion.id)

    prestacion
  end

  def find_by_slug(nombre)
    slug = StringHelper.sluggify(nombre)
    raise PrestacionNotExistsError unless exists_prestacion_with_slug(slug)

    load_object(dataset.first!(slug: slug))
  end

  def find_by_centro(centro_id)
    load_collection dataset_with_centros.where(centro_id: centro_id)
  end

  def delete_all
    dataset_prestaciones_de_centros.delete
    dataset.delete
  end

  private

  def exists_prestacion_with_id(id)
    !dataset.where(id: id).blank?
  end

  def exists_prestacion_with_slug(slug)
    !dataset.where(slug: slug).blank?
  end

  def dataset_with_centros
    DB[@table_name].join(@table_join_centros, prestacion_id: :id)
  end

  def dataset_prestaciones_de_centros
    DB[@table_join_centros]
  end

  def load_object(a_record)
    prestacion = Prestacion.new(a_record[:name], a_record[:cost])
    prestacion.id = a_record[:prestacion_id] ||= a_record[:id]
    prestacion.slug = a_record[:slug]

    prestacion
  end

  def changeset(prestacion)
    {
      name: prestacion.nombre,
      slug: prestacion.slug,
      cost: prestacion.costo
    }
  end
end
