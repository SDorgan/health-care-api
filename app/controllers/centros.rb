require_relative '../errors/prestacion_not_exists_error'
require_relative '../errors/coordenadas_invalidas_error'
require_relative '../errors/centro_ya_existente_error'

HealthAPI::App.controllers :centros do
  get :index do
    nombre_prestacion = request.params['prestacion']

    centros = if nombre_prestacion.nil?
                CentroRepository.new.all
              else
                CentroRepository.new.find_by_prestacion(nombre_prestacion)
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
