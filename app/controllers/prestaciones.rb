HealthAPI::App.controllers :prestaciones do
  before do
    halt 403 if request.env['HTTP_API_KEY'].nil? || !request.env['HTTP_API_KEY'].eql?(API_KEY)
  end

  get :index do
    prestaciones = PrestacionRepository.new.all

    PrestacionResponseBuilder.create_from_all(prestaciones)
  end

  post :index do
    params = JSON.parse(request.body.read)

    prestacion = Prestacion.new(params['nombre'], params['costo'])

    prestacion = PrestacionRepository.new.save(prestacion)

    status 201

    PrestacionResponseBuilder.create_from(prestacion)

  rescue PrestacionSinNombreError, PrestacionCostoInvalido => e
    status 400
    body e.message
  end
end
