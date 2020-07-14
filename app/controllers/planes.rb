HealthAPI::App.controllers :planes do
  get :index do
    planes = PlanRepository.new.all

    response = PlanResponseBuilder.create_from_all(planes)

    response.to_json
  end

  post :index do
    params = JSON.parse(request.body.read)

    plan = Plan.new(params['nombre'])

    plan = PlanRepository.new.save(plan)

    response = PlanResponseBuilder.create_from(plan)

    status 201
    response.to_json
  end
end
