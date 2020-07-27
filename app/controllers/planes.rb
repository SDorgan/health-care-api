HealthAPI::App.controllers :planes do
  get :index do
    planes = PlanRepository.new.all

    PlanResponseBuilder.create_from_all(planes)
  end

  post :index do
    params = JSON.parse(request.body.read)

    cobertura_visitas = if params.include?('limite_cobertura_visitas')
                          CoberturaVisita.new(params['limite_cobertura_visitas'],
                                              params['copago'])
                        else
                          CoberturaVisitaInfinita.new(params['copago'])
                        end

    cobertura_medicamentos = CoberturaMedicamentos.new(params['cobertura_medicamentos'])

    plan = Plan.new(nombre: params['nombre'],
                    costo: params['costo'],
                    cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos,
                    edad_minima: params['edad_minima'],
                    edad_maxima: params['edad_maxima'],
                    cantidad_hijos_maxima: params['cantidad_hijos_maxima'])

    plan = PlanRepository.new.save(plan)
    status 201

    PlanResponseBuilder.create_from(plan)
  end
end
