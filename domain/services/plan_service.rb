class PlanService
  def initialize(repo_planes)
    @repo_planes = repo_planes
  end

  def buscar(params = {})
    nombre_plan = params[:nombre]

    if nombre_plan.nil?
      planes = @repo_planes.all
      PlanResponseBuilder.create_from_all(planes)
    else
      plan = @repo_planes.find_by_name(nombre_plan)
      PlanResponseBuilder.create_from(plan)
    end
  rescue PlanNoEncontrado
    raise PlanInexistenteError
  end

  def registrar(params = {})
    limite_visitas = params['limite_cobertura_visitas']
    costo_copago = params['copago']
    porcentaje_medicamentos = params['cobertura_medicamentos']

    cobertura_visitas = if !limite_visitas.nil?
                          CoberturaVisita.new(limite_visitas,
                                              costo_copago)
                        else
                          CoberturaVisitaInfinita.new(costo_copago)
                        end

    cobertura_medicamentos = CoberturaMedicamentos.new(porcentaje_medicamentos)

    data = format_data(params)

    data[:cobertura_visitas] = cobertura_visitas
    data[:cobertura_medicamentos] = cobertura_medicamentos

    plan = Plan.new(data)

    @repo_planes.save(plan)
  end

  private

  def format_data(params)
    data = {}
    data[:nombre] = params['nombre']
    data[:costo] = params['costo']
    data[:edad_minima] = params['edad_minima']
    data[:edad_maxima] = params['edad_maxima']
    data[:cantidad_hijos_maxima] = params['cantidad_hijos_maxima']
    data[:conyuge] = params['conyuge']

    data
  end
end
