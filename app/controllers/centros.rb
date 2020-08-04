require_relative '../errors/prestacion_not_exists_error'
require_relative '../errors/coordenadas_invalidas_error'
require_relative '../errors/centro_ya_existente_error'

HealthAPI::App.controllers :centros do
  get :index do
    nombre_prestacion = request.params['prestacion']

    service = CentroService.new(CentroRepository.new)

    centros = service.buscar(nombre_prestacion: nombre_prestacion)

    CentroResponseBuilder.create_from_all(centros)

  rescue PrestacionNotExistsError => e
    status 404
    body e.message
  end

  post :index do
    params = JSON.parse(request.body.read)

    service = CentroService.new(CentroRepository.new)

    centro = service.registrar(params['nombre'], params['latitud'], params['longitud'])

    status 201

    CentroResponseBuilder.create_from(centro)

  rescue CoordenadasInvalidasError,
         CentroYaExistenteError,
         CentroCoordenadasInvalidas => e
    status 400
    body e.message
  end
end
