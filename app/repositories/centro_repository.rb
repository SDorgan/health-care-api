class CentroRepository < BaseRepository
  def initialize
    super(:centros)
    @table_join_prestaciones = :prestaciones_de_centros
  end

  def save(centro)
    id = insert(centro)
    centro.id = id

    centro
  end

  def find(id_)
    raise CentroNoEncontrado unless exists_centro_with_id(id_)

    super(id_)
  end

  def exists_by_name(nombre)
    slug = StringHelper.sluggify(nombre)

    return false if find_by_slug(slug).nil?

    true
  end

  def exists_by_coordinates(latitud, longitud)
    return false if find_by_similar_coordinates(latitud, longitud).nil?

    true
  end

  def find_by_prestacion(nombre_prestacion)
    prestacion = PrestacionRepository.new.find_by_name(nombre_prestacion)

    load_collection dataset_with_prestaciones.where(prestacion_id: prestacion.id)
  end

  def add_prestacion(centro, prestacion)
    changeset = {
      centro_id: centro.id,
      prestacion_id: prestacion.id
    }

    dataset_prestaciones_de_centros.insert(changeset)
  end

  def contains_prestacion(centro, prestacion)
    !dataset_prestaciones_de_centros.where(centro_id: centro.id,
                                           prestacion_id: prestacion.id).blank?
  end

  def full_load(id)
    centro = find(id)
    centro.prestaciones = PrestacionRepository.new.find_by_centro(id)

    centro
  end

  def delete_all
    dataset_prestaciones_de_centros.delete
    dataset.delete
  end

  private

  def dataset_with_prestaciones
    DB[@table_name].join(@table_join_prestaciones, centro_id: :id)
  end

  def exists_centro_with_id(id)
    !dataset.where(id: id).blank?
  end

  def dataset_prestaciones_de_centros
    DB[@table_join_prestaciones]
  end

  def load_object(a_record)
    centro = Centro.new(a_record[:name], a_record[:latitude], a_record[:longitude])
    centro.slug = a_record[:slug]
    centro.id = a_record[:centro_id] ||= a_record[:id]

    centro
  end

  def find_by_slug(slug)
    load_object(dataset.first!(slug: slug))
  rescue Sequel::NoMatchingRow
    nil
  end

  def find_by_similar_coordinates(lat, lon)
    load_object(dataset.first!(latitude: lat.floor..lat.ceil, longitude: lon.floor..lon.ceil)) # rubocop:disable Metrics/LineLength
  rescue Sequel::NoMatchingRow
    nil
  end

  def changeset(centro)
    {
      name: centro.nombre,
      slug: centro.slug,
      longitude: centro.longitud,
      latitude: centro.latitud
    }
  end
end
