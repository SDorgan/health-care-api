HealthAPI::App.controllers :visitas do
  post :index do
    params = JSON.parse(request.body.read)

    afiliado_id = params['afiliado']

    prestacion = PrestacionRepository.new.find_by_name(params['prestacion'])

    visita_medica = VisitaMedica.new(afiliado_id, prestacion)

    visita_medica = VisitaMedicaRepository.new.save(visita_medica)

    status 201

    VisitaMedicaResponseBuilder.create_from(visita_medica)
  end
end
