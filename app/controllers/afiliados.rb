HealthAPI::App.controllers :afiliados do
  get :index do
    afiliados = AfiliadoRepository.new.all

    AfiliadoResponseBuilder.create_from_all(afiliados)
  end

  post :index do
    params = JSON.parse(request.body.read)
    plan_repository = PlanRepository.new
    plan = plan_repository.find_plan(params['nombre_plan'].to_s)

    afiliado = Afiliado.new(params['nombre'], plan.id)

    afiliado = AfiliadoRepository.new.save(afiliado)

    status 201

    AfiliadoResponseBuilder.create_from(afiliado)
  end
end
