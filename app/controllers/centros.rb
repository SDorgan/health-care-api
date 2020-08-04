HealthAPI::App.controllers :centros do
  get :index do
    nombre_prestacion = request.params['prestacion']

    service = CentroService.new(CentroRepository.new, PrestacionRepository.new)

    centros = service.buscar(nombre_prestacion: nombre_prestacion)

    CentroResponseBuilder.create_from_all(centros)

  rescue PrestacionInexistenteError => e
    status 404
    body e.message
  end

  post :index do
    params = JSON.parse(request.body.read)

    service = CentroService.new(CentroRepository.new, PrestacionRepository.new)

    centro = service.registrar(params['nombre'], params['latitud'], params['longitud'])

    status 201

    CentroResponseBuilder.create_from(centro)

  rescue CentroCoordenadasInvalidas,
         CentroYaExistenteError => e
    status 400
    body e.message
  end
end
