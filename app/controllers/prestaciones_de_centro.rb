require_relative '../errors/prestacion_not_exists_error'
require_relative '../errors/centro_inexistente_error'
require_relative '../errors/centro_ya_contiene_prestacion_error'
HealthAPI::App.controllers :prestaciones, parent: :centros do
  get :index do
    centro = CentroRepository.new.full_load(params[:centro_id])

    PrestacionResponseBuilder.create_from_all(centro.prestaciones)
  end

  post :index do
    json_params = JSON.parse(request.body.read)
    repo = CentroRepository.new
    centro = repo.find(params[:centro_id])
    prestacion = PrestacionRepository.new.find(json_params['prestacion'])

    repo.add_prestacion_to_centro(centro, prestacion.id)

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
