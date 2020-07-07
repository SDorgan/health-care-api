HealthAPI::App.controllers :planes do
  get :index do
    planes = PlanRepository.new.all

    output = { 'planes': [] }

    planes.each do |plan|
      output[:planes] << {
        'id': plan.id,
        'nombre': plan.nombre
      }
    end

    output.to_json
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
