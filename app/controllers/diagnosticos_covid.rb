HealthAPI::App.controllers :covid do
  post :index do
    params = JSON.parse(request.body.read)

    _temperatura = params['temperatura'].to_i

    CovidResponseBuilder.create_from(false)
  end
end
