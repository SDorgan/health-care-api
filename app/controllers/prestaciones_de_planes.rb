HealthAPI::App.controllers :prestaciones, parent: :planes do
  get :index do
    plan = PlanRepository.new.find(params[:plane_id])
    prestaciones = PrestacionDePlanRepository.new.find_by_plan(plan)

    PrestacionResponseBuilder.create_from_all(prestaciones)
  end

  post :index do
    params = JSON.parse(request.body.read)

    plan = PlanRepository.new.find(params[:plane_id])
    prestacion = PrestacionRepository.new.find_by_name(params['prestacion'])

    prestacion_de_plan = PrestacionDePlan.new(plan, prestacion)
    PrestacionDePlanRepository.new.save(prestacion_de_plan)

    status 201

    'ok'
  end
end
