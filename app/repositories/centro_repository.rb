class CentroRepository
  def initialize
    @table_name = :centros
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

  def find(id)
    load_object(dataset.first!(pk_column => id))
  end

  def full_load(id)
    centro = find(id)
    centro.prestaciones = PrestacionRepository.new.find_by_centro(id)

    centro
  end

  def all
    load_collection(dataset)
  end

  def destroy(a_record)
    find_dataset_by_id(a_record.id).delete.positive?
  end
  alias delete destroy

  def delete_all
    dataset_prestaciones_de_centros.delete
    dataset.delete
  end

  private

  def insert(a_record)
    dataset.insert(changeset(a_record))
  end

  def dataset_with_prestaciones
    DB[@table_name].join(@table_join_prestaciones, centro_id: :id)
  end

  def dataset_prestaciones_de_centros
    DB[@table_join_prestaciones]
  end

  def dataset
    DB[@table_name]
  end

  def pk_column
    Sequel[@table_name][:id]
  end

  def load_object(a_record)
    centro = Centro.new(a_record[:name])
    centro.id = a_record[:id]

    centro
  end

  def load_collection(rows)
    rows.map { |a_record| load_object(a_record) }
  end

  def changeset(centro)
    {
      name: centro.nombre
    }
  end
end
