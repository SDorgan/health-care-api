require_relative '../errors/prestacion_not_exists_error'
require_relative '../errors/centro_inexistente_error'
require_relative '../errors/centro_ya_contiene_prestacion_error'

HealthAPI::App.controllers :prestaciones, parent: :centros do
  get :index do
    centro = CentroRepository.new.full_load(params[:centro_id])

    PrestacionResponseBuilder.create_from_all(centro.prestaciones)
  end

  post :index do
    body_params = JSON.parse(request.body.read)

    centro = CentroRepository.new.find(params[:centro_id])
    prestacion = PrestacionRepository.new.find(body_params['prestacion'])

    CentroRepository.new.add_prestacion(centro, prestacion)

    status 201

    'ok'

  rescue PrestacionNotExistsError, CentroInexistenteError => e
    status 404
    body e.message

  rescue CentroYaContienePrestacionError => e
    status 400
    body e.message
  end
end
