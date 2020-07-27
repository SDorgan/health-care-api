require_relative '../errors/id_not_afiliado_error'

HealthAPI::App.controllers :visitas do
  post :index do
    params = JSON.parse(request.body.read)

    afiliado_id = params['afiliado']

    raise IdNotAfiliadoError unless AfiliadoRepository.new.exists_afiliado_with_id(afiliado_id)

    prestacion = PrestacionRepository.new.find(params['prestacion'])

    visita_medica = VisitaMedica.new(afiliado_id, prestacion)

    visita_medica = VisitaMedicaRepository.new.save(visita_medica)

    status 201

    VisitaMedicaResponseBuilder.create_from(visita_medica)

  rescue IdNotAfiliadoError => e
    status 401
    body e.message
  end
end
