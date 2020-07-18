class AfiliadoRepository
  def initialize
    @table_name = :afiliados
  end

  def save(afiliado)
    if find_dataset_by_id(afiliado.id).first
      update(afiliado)
    else
      id = insert(afiliado)
      afiliado.id = id
    end

    afiliado
  end

  def find(id)
    load_object(dataset.first!(pk_column => id))
  end

  def find_by_telegram_id(tele_id)
    load_object(dataset.first!(id_telegram: tele_id))
  end

  def find_sospechosos
    load_collection dataset.where(covid_suspect: true)
  end

  def es_sospechoso(id)
    afiliado = load_object(dataset.first!(pk_column => id))
    afiliado.covid_sospechoso
  end

  def destroy(a_record)
    find_dataset_by_id(a_record.id).delete.positive?
  end
  alias delete destroy

  def delete_all
    dataset.delete
  end

  def all
    load_collection(dataset)
  end

  private

  def find_dataset_by_id(id)
    dataset.where(pk_column => id)
  end

  def insert(a_record)
    dataset.insert(changeset(a_record))
  end

  def update(a_record)
    find_dataset_by_id(a_record.id).update(changeset(a_record))
  end

  def dataset
    DB[@table_name]
  end

  def pk_column
    Sequel[@table_name][:id]
  end

  def load_object(a_record)
    afiliado = Afiliado.new(a_record[:name], a_record[:plan_id])
    afiliado.id = a_record[:id]
    afiliado.id_telegram = a_record[:id_telegram]
    afiliado.covid_sospechoso = a_record[:covid_suspect]
    afiliado
  end

  def load_collection(rows)
    rows.map { |a_record| load_object(a_record) }
  end

  def changeset(afiliado)
    {
      name: afiliado.nombre,
      id_telegram: afiliado.id_telegram.to_s,
      plan_id: afiliado.plan_id,
      covid_suspect: afiliado.covid_sospechoso
    }
  end
end
