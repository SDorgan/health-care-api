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

  def find_by_name(nombre)
    load_object(dataset.first!(name: nombre))
  end

  def find_by_centro(centro_id)
    load_collection dataset_with_centros.where(centro_id: centro_id)
  end

  def delete_all
    dataset_prestaciones_de_centros.delete
    dataset.delete
  end

  private

  def dataset_with_centros
    DB[@table_name].join(:prestaciones_de_centros, prestacion_id: :id)
  end

  def dataset_prestaciones_de_centros
    DB[@table_join_centros]
  end

  def load_object(a_record)
    prestacion = Prestacion.new(a_record[:name], a_record[:cost])
    prestacion.id = a_record[:prestacion_id] ||= a_record[:id]

    prestacion
  end

  def changeset(prestacion)
    {
      name: prestacion.nombre,
      cost: prestacion.costo
    }
  end
end
