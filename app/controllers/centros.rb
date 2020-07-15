HealthAPI::App.controllers :centros do
  post :index do
    params = JSON.parse(request.body.read)

    centro = Centro.new(params['nombre'])

    centro = CentroRepository.new.save(centro)

    status 201

    CentroResponseBuilder.create_from(centro)
  end
end
