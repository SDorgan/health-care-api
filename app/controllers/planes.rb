HealthAPI::App.controllers :planes do
  get :index do
    planes = PlanRepository.new.all

    PlanResponseBuilder.create_from_all(planes)
  end

  post :index do
    params = JSON.parse(request.body.read)

    cobertura_visitas = if params.include?('limite_cobertura_visitas')
                          CoberturaVisita.new(params['limite_cobertura_visitas'])
                        else
                          CoberturaVisitaInfinita.new
                        end

    plan = Plan.new(params['nombre'],
                    params['costo'],
                    params['copago'],
                    params['cobertura_medicamentos'],
                    cobertura_visitas)

    plan = PlanRepository.new.save(plan)
    status 201

    PlanResponseBuilder.create_from(plan)
  end
end
