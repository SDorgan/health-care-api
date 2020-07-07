HealthAPI::App.controllers :planes do
  get :index do
    { 'planes': [
      { id: 1, 'nombre': 'neo' },
      { id: 2, 'nombre': 'familiar' }
    ] }.to_json
  end

  post :index do
    params = JSON.parse(request.body.read)

    plan = Plan.new(params['nombre'])

    plan_id = PlanRepository.new.save(plan)

    status 201

    {
      'plan': {
        'id': plan_id,
        'nombre': plan.nombre
      }
    }.to_json
  end
end
