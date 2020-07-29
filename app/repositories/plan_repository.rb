class PlanRepository < BaseRepository
  def initialize
    super(:planes)
  end

  def save(plan)
    id = insert(plan)

    plan.id = id

    plan
  end

  def find_by_slug(nombre)
    slug = nombre.downcase.tr('àáäâãèéëẽêìíïîĩòóöôõùúüûũñç ', 'aaaaaeeeeeiiiiiooooouuuuunc_')
    load_object(dataset.first!(slug: slug))
  rescue Sequel::NoMatchingRow
    raise PlanInexistenteError
  end

  private

  def load_object(a_record) # rubocop:disable Metrics/AbcSize
    cobertura_visitas = if a_record[:visit_limit].eql?(CoberturaVisitaInfinita::LIMITE)
                          CoberturaVisitaInfinita.new(a_record[:copay])
                        else
                          CoberturaVisita.new(a_record[:visit_limit], a_record[:copay])
                        end
    cobertura_medicamentos = CoberturaMedicamentos.new(a_record[:medicine_coverage])

    plan = Plan.new(nombre: a_record[:name], costo: a_record[:cost],
                    cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos,
                    edad_minima: a_record[:minimum_age], edad_maxima: a_record[:maximum_age],
                    cantidad_hijos_maxima: a_record[:children],
                    conyuge: Plan.mapeo_conyuge.key(a_record[:spouse]))

    plan.id = a_record[:id]
    plan.slug = a_record[:slug]

    plan
  end

  def changeset(plan) # rubocop:disable Metrics/AbcSize
    {
      name: plan.nombre,
      slug: plan.slug,
      cost: plan.costo,
      visit_limit: plan.cobertura_visitas.cantidad,
      copay: plan.cobertura_visitas.copago,
      medicine_coverage: plan.cobertura_medicamentos.porcentaje,
      minimum_age: plan.edad_minima,
      maximum_age: plan.edad_maxima,
      children: plan.cantidad_hijos_maxima,
      spouse: Plan.mapeo_conyuge[plan.conyuge] || 0
    }
  end
end
