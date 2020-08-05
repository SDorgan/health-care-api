HealthAPI::App.controllers :prestaciones, parent: :centros do
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

    'ok'

  rescue PrestacionInexistenteError, CentroInexistenteError => e
    status 404
    body e.message

  rescue CentroYaContienePrestacionError => e
    status 400
    body e.message
  end
end
