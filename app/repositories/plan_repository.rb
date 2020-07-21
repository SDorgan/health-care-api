class PlanRepository
  def initialize
    @table_name = :planes
  end

  def save(plan)
    id = insert(plan)

    plan.id = id

    plan
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

  def pk_column
    Sequel[@table_name][:id]
  end

  def load_object(a_record)
    cobertura_visitas = if a_record[:visit_limit].eql?(CoberturaVisitaInfinita::LIMITE)
                          CoberturaVisitaInfinita.new(a_record[:copay])
                        else
                          CoberturaVisita.new(a_record[:visit_limit], a_record[:copay])
                        end

    plan = Plan.new(a_record[:name], a_record[:cost],
                    a_record[:medicine_coverage],
                    cobertura_visitas)

    plan.id = a_record[:id]

    plan
  end

  def load_collection(rows)
    rows.map { |a_record| load_object(a_record) }
  end

  def changeset(plan)
    {
      name: plan.nombre,
      cost: plan.costo,
      visit_limit: plan.cobertura_visitas.cantidad,
      copay: plan.cobertura_visitas.copago,
      medicine_coverage: plan.cobertura_medicamentos
    }
  end
end
