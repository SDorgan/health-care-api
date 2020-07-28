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

  def add_prestacion_to_centro(centro, prestacion_id)
    changeset = {
      centro_id: centro.id,
      prestacion_id: prestacion_id
    }

    dataset_prestaciones_de_centros.insert(changeset)
  end

  def find(id_)
    raise CentroInexistenteError unless exists_centro_with_id(id_)

    super(id_)
  end

  def full_load(id)
    centro = find(id)
    centro.prestaciones = PrestacionRepository.new.find_by_centro(id)

    centro
  end

  def find_by_prestacion(prestacion_id)
    load_collection dataset_with_prestaciones.where(prestacion_id: prestacion_id)
  end

  def delete_all
    dataset_prestaciones_de_centros.delete
    dataset.delete
  end

  def centro_contains_prestacion(centro_id, prestacion)
    !dataset_prestaciones_de_centros.where(centro_id: centro_id, prestacion_id: prestacion.id).blank? # rubocop:disable Metrics/LineLength
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
    centro = Centro.new(a_record[:name])
    centro.id = a_record[:centro_id] ||= a_record[:id]

    centro
  end

  def changeset(centro)
    {
      name: centro.nombre,
      longitude: centro.longitud,
      latitude: centro.latitud
    }
  end
end
