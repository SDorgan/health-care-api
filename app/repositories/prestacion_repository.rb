class PrestacionRepository
  def initialize
    @table_name = :prestaciones
  end

  def save(prestacion)
    id = insert(prestacion)

    prestacion.id = id

    prestacion
  end

  def find(id)
    load_object(dataset.first!(pk_column => id))
  end

  def find_by_name(nombre)
    load_object(dataset.first!(name: nombre))
  end

  def all
    load_collection(dataset)
  end

  def find_by_centro(centro_id)
    load_collection dataset_with_centros.where(centro_id: centro_id)
  end

  def destroy(a_record)
    find_dataset_by_id(a_record.id).delete.positive?
  end
  alias delete destroy

  def delete_all
    dataset.delete
  end

  private

  def insert(a_record)
    dataset.insert(changeset(a_record))
  end

  def dataset
    DB[@table_name]
  end

  def dataset_with_centros
    DB[@table_name].join(:prestaciones_de_centros, prestacion_id: :id)
  end

  def pk_column
    Sequel[@table_name][:id]
  end

  def load_object(a_record)
    prestacion = Prestacion.new(a_record[:name], a_record[:cost])
    prestacion.id = a_record[:prestacion_id] ||= a_record[:id]

    prestacion
  end

  def load_collection(rows)
    rows.map { |a_record| load_object(a_record) }
  end

  def changeset(prestacion)
    {
      name: prestacion.nombre,
      cost: prestacion.costo
    }
  end
end
