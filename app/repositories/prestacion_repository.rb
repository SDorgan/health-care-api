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

  def all
    load_collection(dataset)
  end

  private

  def insert(a_record)
    dataset.insert(changeset(a_record))
  end

  def dataset
    DB[@table_name]
  end

  def pk_column
    Sequel[@table_name][:id]
  end

  def load_object(a_record)
    prestacion = Prestacion.new(a_record[:name])
    prestacion.id = a_record[:id]

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
