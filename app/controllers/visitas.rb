HealthAPI::App.controllers :visitas do
  before do
    halt 403 if request.env['HTTP_API_KEY'].nil? || !request.env['HTTP_API_KEY'].eql?(API_KEY)
  end
  post :index do
    params = JSON.parse(request.body.read)

    afiliado_id = params['afiliado']
    prestacion_id = params['prestacion']
    centro_id = params['centro']

    service = VisitaService.new(AfiliadoRepository.new,
                                PrestacionRepository.new,
                                CentroRepository.new,
                                VisitaMedicaRepository.new)

    visita_medica = service.registrar(afiliado_id, prestacion_id, centro_id)

    status 201

    VisitaMedicaResponseBuilder.create_from(visita_medica)

  rescue UsuarioNoAfiliadoError => e
    status 401
    body e.message

  rescue PrestacionInexistenteError, CentroInexistenteError, CentroNoContienePrestacionError => e
    status 404
    body e.message
  end
end
