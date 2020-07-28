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
  end
end

HealthAPI::App.controllers :centros, parent: :prestaciones do
  get :index do
    prestacion = PrestacionRepository.new.full_load(params[:prestacione_id])

    CentroResponseBuilder.create_from_all(prestacion.centros)
  end
end
