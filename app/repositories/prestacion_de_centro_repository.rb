class PrestacionDeCentroRepository
  def initialize
    @table_name = :prestaciones_de_centros
  end

  def save(prestacion_de_centro)
    id = insert(prestacion_de_centro)

    prestacion_de_centro.id = id

    prestacion_de_centro
  end

  def all
    load_collection(dataset)
  end

  def find_by_centro(centro)
    collection = load_collection dataset.where(centro_id: centro.id)

    prestaciones = []

    collection.each do |prestacion_de_centro|
      prestaciones << PrestacionRepository.new.find(prestacion_de_centro.prestacion_id)
    end

    prestaciones
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

  def load_object(a_record)
    centro = CentroRepository.new.find(a_record[:centro_id])
    prestacion = PrestacionRepository.new.find(a_record[:prestacion_id])

    prestacion_de_centro = PrestacionDePlan.new(centro, prestacion)
    prestacion_de_centro.id = a_record[:id]

    prestacion_de_centro
  end

  def load_collection(rows)
    rows.map { |a_record| load_object(a_record) }
  end

  def changeset(prestacion_de_centro)
    {
      centro_id: prestacion_de_centro.centro_id,
      prestacion_id: prestacion_de_centro.prestacion_id
    }
  end
end
