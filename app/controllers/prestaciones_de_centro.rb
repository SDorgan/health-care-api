HealthAPI::App.controllers :prestaciones, parent: :centros do
  before do
    halt 403 if request.env['HTTP_API_KEY'].nil? || !request.env['HTTP_API_KEY'].eql?(API_KEY)
  end

  get :index do
    centro = CentroRepository.new.full_load(params[:centro_id])

    PrestacionResponseBuilder.create_from_all(centro.prestaciones)
  end

  post :index do
    body_params = JSON.parse(request.body.read)

    service = PrestacionDeCentroService.new(CentroRepository.new,
                                            PrestacionRepository.new)

    service.registrar(params[:centro_id], body_params['prestacion'])

    status 201

    respuesta = { 'respuesta': 'ok' }
    body respuesta.to_json

  rescue PrestacionInexistenteError, CentroInexistenteError => e
    status 404
    respuesta = { 'respuesta': 'error', 'mensaje': e.message }
    body respuesta.to_json

  rescue CentroYaContienePrestacionError => e
    status 400
    respuesta = { 'respuesta': 'error', 'mensaje': e.message }
    body respuesta.to_json
  end
end
