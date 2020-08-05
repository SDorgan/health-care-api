HealthAPI::App.controllers :planes do
  before do
    halt 403 if request.env['HTTP_API_KEY'].nil? || !request.env['HTTP_API_KEY'].eql?(API_KEY)
  end

  get :index do
    nombre_plan = request.params['nombre']

    service = PlanService.new(PlanRepository.new)

    response = service.buscar(nombre: nombre_plan)

    response
  rescue PlanInexistenteError => e
    status 404
    respuesta = { 'respuesta': 'error', 'mensaje': e.message }
    body respuesta.to_json
  end

  post :index do
    params = JSON.parse(request.body.read)

    service = PlanService.new(PlanRepository.new)

    plan = service.registrar(params)

    status 201

    PlanResponseBuilder.create_from(plan)

  rescue PlanArgumentosInvalidosError => e
    status 400
    respuesta = { 'respuesta': 'error', 'mensaje': e.message }
    body respuesta.to_json
  end
end
