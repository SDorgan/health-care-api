HealthAPI::App.controllers :planes do
  get :index do
    planes = PlanRepository.new.all

    PlanResponseBuilder.create_from_all(planes)
  end

  post :index do
    params = JSON.parse(request.body.read)

    plan = Plan.new(params['nombre'], params['costo'], params['limite_cobertura_visitas'], 0)

    plan = PlanRepository.new.save(plan)

    status 201

    PlanResponseBuilder.create_from(plan)
  end
end
