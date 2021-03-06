require_relative '../errors/prestacion_not_exists_error'
require_relative '../errors/coordenadas_invalidas_error'
require_relative '../errors/centro_ya_existente_error'
HealthAPI::App.controllers :centros do
  get :index do
    param_prestacion = request.params['prestacion']
    if param_prestacion.nil?
      centros = CentroRepository.new.all
    else
      prestacion = PrestacionRepository.new.full_load_by_name(param_prestacion)
      centros = prestacion.centros
    end

    CentroResponseBuilder.create_from_all(centros)
  rescue PrestacionNotExistsError => e
    status 404
    body e.message
  end

  post :index do
    params = JSON.parse(request.body.read)

    centro = Centro.new(params['nombre'], params['latitud'], params['longitud'])

    centro = CentroRepository.new.save(centro)

    status 201

    CentroResponseBuilder.create_from(centro)
  rescue CoordenadasInvalidasError, CentroYaExistenteError => e
    status 400
    body e.message
  end
end
