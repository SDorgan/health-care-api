HealthAPI::App.controllers :centros do
  before do
    halt 403 if request.env['HTTP_API_KEY'].nil? || !request.env['HTTP_API_KEY'].eql?(API_KEY)
  end

  get :index do
    nombre_prestacion = request.params['prestacion']
    latitud = request.params['latitud']
    longitud = request.params['longitud']

    service = CentroService.new(CentroRepository.new,
                                PrestacionRepository.new,
                                CalculadorDistancia.new)

    centros = service.buscar(nombre_prestacion: nombre_prestacion,
                             latitud: latitud,
                             longitud: longitud)

    CentroResponseBuilder.create_from_all(centros)

  rescue PrestacionInexistenteError => e
    status 404
    respuesta = { 'respuesta': 'error', 'mensaje': e.message }
    body respuesta.to_json
  end

  post :index do
    params = JSON.parse(request.body.read)

    service = CentroService.new(CentroRepository.new,
                                PrestacionRepository.new,
                                CalculadorDistancia.new)

    centro = service.registrar(params['nombre'], params['latitud'], params['longitud'])

    status 201

    CentroResponseBuilder.create_from(centro)

  rescue CentroCoordenadasInvalidas, CentroYaExistenteError => e
    status 400
    respuesta = { 'respuesta': 'error', 'mensaje': e.message }
    body respuesta.to_json
  end
end
