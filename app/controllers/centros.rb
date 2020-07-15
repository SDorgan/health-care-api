HealthAPI::App.controllers :centros do
  get :index do
    centros = CentroRepository.new.all

    CentroResponseBuilder.create_from_all(centros)
  end

  post :index do
    params = JSON.parse(request.body.read)

    centro = Centro.new(params['nombre'])

    centro = CentroRepository.new.save(centro)

    status 201

    CentroResponseBuilder.create_from(centro)
  end
end
