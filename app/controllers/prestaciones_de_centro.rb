HealthAPI::App.controllers :prestaciones, parent: :centros do
  post :index do
    json_params = JSON.parse(request.body.read)

    centro = CentroRepository.new.find(params[:centro_id])
    prestacion = PrestacionRepository.new.find_by_name(json_params['prestacion'])

    prestacion_de_centro = PrestacionDeCentro.new(centro, prestacion)
    PrestacionDeCentroRepository.new.save(prestacion_de_centro)

    status 201

    'ok'
  end
end
