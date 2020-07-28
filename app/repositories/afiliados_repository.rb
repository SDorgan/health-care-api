class AfiliadoRepository < BaseRepository
  def initialize
    super(:afiliados)
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

  def find(id_)
    raise IdNotAfiliadoError unless exists_afiliado_with_id(id_)

    super(id_)
  end

  def exists_afiliado_with_id(id)
    !dataset.where(id: id).blank?
  end

  def find_by_telegram_id(tele_id)
    raise IdNotAfiliadoError unless exists_afiliado_with_telegram_id(tele_id)

    load_object(dataset.first!(id_telegram: tele_id))
  end

  def find_sospechosos
    load_collection dataset.where(covid_suspect: true)
  end

  def es_sospechoso(id)
    afiliado = load_object(dataset.first!(pk_column => id))
    afiliado.covid_sospechoso
  end

  private

  def find_dataset_by_id(id)
    dataset.where(pk_column => id)
  end

  def exists_afiliado_with_telegram_id(tele_id)
    !dataset.where(id_telegram: tele_id).blank?
  end

  def update(a_record)
    find_dataset_by_id(a_record.id).update(changeset(a_record))
  end

  def load_object(a_record)
    plan = PlanRepository.new.find(a_record[:plan_id])

    afiliado = Afiliado.new(a_record[:name], plan)

    afiliado.id = a_record[:id]
    afiliado.id_telegram = a_record[:id_telegram]
    afiliado.covid_sospechoso = a_record[:covid_suspect]

    afiliado
  end

  def changeset(afiliado)
    {
      name: afiliado.nombre,
      id_telegram: afiliado.id_telegram.to_s,
      plan_id: afiliado.plan.id,
      covid_suspect: afiliado.covid_sospechoso
    }
  end
end
