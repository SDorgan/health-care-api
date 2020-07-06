HealthAPI::App.controllers :planes do
  get :index do
    { 'planes': [
      { id: 1, 'nombre': 'neo' },
      { id: 2, 'nombre': 'familiar' }
    ] }.to_json
  end

  post :index do
    params = JSON.parse(request.body.read)
    status 200

    params.to_json
  end
end
