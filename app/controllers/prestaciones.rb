HealthAPI::App.controllers :prestaciones do
  get :index do
    planes = PrestacionRepository.new.all

    PrestacionResponseBuilder.create_from_all(planes)
  end

  post :index do
    params = JSON.parse(request.body.read)

    prestacion = Prestacion.new(params['nombre'], params['costo'])

    prestacion = PrestacionRepository.new.save(prestacion)

    status 201

    PrestacionResponseBuilder.create_from(prestacion)
  end
end