class VisitaMedicaRepository
  def initialize
    @table_name = :visitas_medicas
  end

  def find(id)
    load_object(dataset.first!(pk_column => id))
  end

  def save(visita_medica)
    id = insert(visita_medica)

    visita_medica.id = id

    visita_medica
  end

  private

  def insert(a_record)
    a_record.created_on = Date.today

    dataset.insert(changeset(a_record))
  end

  def dataset
    DB[@table_name]
  end

  def load_object(a_record)
    prestacion = PrestacionRepository.new.find(a_record[:prestacion_id])

    visita_medica = VisitaMedica.new(a_record[:afiliado_id], prestacion)
    visita_medica.id = a_record[:id]
    visita_medica.created_on = a_record[:created_on]

    visita_medica
  end

  def pk_column
    Sequel[@table_name][:id]
  end

  def changeset(visita_medica)
    {
      afiliado_id: visita_medica.afiliado_id,
      prestacion_id: visita_medica.prestacion_id,
      created_on: visita_medica.created_on
    }
  end
end
