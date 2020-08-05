HealthAPI::App.controllers :planes do
  before do
    halt 403 if request.env['HTTP_API_KEY'].nil? || !request.env['HTTP_API_KEY'].eql?(API_KEY)
  end
  get :index do
    nombre_plan = request.params['nombre']

    if nombre_plan.nil?
      planes = PlanRepository.new.all
      PlanResponseBuilder.create_from_all(planes)
    else
      plan = PlanRepository.new.find_by_name(nombre_plan)
      PlanResponseBuilder.create_from(plan)
    end

  rescue PlanInexistenteError => e
    status 404
    body e.message
  end

  post :index do
    params = JSON.parse(request.body.read)

    plan = Plan.create(nombre: params['nombre'],
                       costo: params['costo'],
                       limite_visitas: params['limite_cobertura_visitas'],
                       porcentaje_medicamentos: params['cobertura_medicamentos'],
                       costo_copago: params['copago'],
                       edad_minima: params['edad_minima'],
                       edad_maxima: params['edad_maxima'],
                       cantidad_hijos_maxima: params['cantidad_hijos_maxima'],
                       conyuge: params['conyuge'])

    plan = PlanRepository.new.save(plan)
    status 201

    PlanResponseBuilder.create_from(plan)

  rescue PlanArgumentosInvalidosError => e
    status 400
    body e.message
  end
end
