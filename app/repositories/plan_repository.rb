class PlanRepository < BaseRepository
  def initialize
    super(:planes)
  end

  def save(plan)
    id = insert(plan)

    plan.id = id

    plan
  end

  def find_by_name(nombre)
    load_object(dataset.first!(name: nombre))
  end

  private

  def load_object(a_record)
    cobertura_visitas = if a_record[:visit_limit].eql?(CoberturaVisitaInfinita::LIMITE)
                          CoberturaVisitaInfinita.new(a_record[:copay])
                        else
                          CoberturaVisita.new(a_record[:visit_limit], a_record[:copay])
                        end
    cobertura_medicamentos = CoberturaMedicamentos.new(a_record[:medicine_coverage])

    plan = Plan.new(a_record[:name], a_record[:cost],
                    cobertura_medicamentos,
                    cobertura_visitas,
                    0)

    plan.id = a_record[:id]

    plan
  end

  def changeset(plan)
    {
      name: plan.nombre,
      cost: plan.costo,
      visit_limit: plan.cobertura_visitas.cantidad,
      copay: plan.cobertura_visitas.copago,
      medicine_coverage: plan.cobertura_medicamentos.porcentaje
    }
  end
end
