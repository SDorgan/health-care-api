class CentroRepository
  def initialize
    @table_name = :centros
  end

  def save(centro)
    id = insert(centro)

    centro.id = id

    centro
  end

  def find(id)
    load_object(dataset.first!(pk_column => id))
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
    centro = Centro.new(a_record[:name])
    centro.id = a_record[:id]

    centro
  end

  def changeset(centro)
    {
      name: centro.nombre
    }
  end
end
