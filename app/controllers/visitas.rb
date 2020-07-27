require_relative '../errors/id_not_afiliado_error'
require_relative '../errors/prestacion_not_exists_error'
require_relative '../errors/centro_inexistente_error'
require_relative '../errors/centro_no_contiene_prestacion_error'
HealthAPI::App.controllers :visitas do
  post :index do
    params = JSON.parse(request.body.read)

    afiliado_id = params['afiliado']

    raise IdNotAfiliadoError unless AfiliadoRepository.new.exists_afiliado_with_id(afiliado_id)

    prestacion = PrestacionRepository.new.find(params['prestacion'])

    centro = CentroRepository.new.find(params['centro'])

    raise CentroNoContienePrestacionError unless CentroRepository.new.centro_contains_prestacion(centro.id, prestacion) # rubocop:disable Metrics/LineLength

    visita_medica = VisitaMedica.new(afiliado_id, prestacion, centro)

    visita_medica = VisitaMedicaRepository.new.save(visita_medica)

    status 201

    VisitaMedicaResponseBuilder.create_from(visita_medica)

  rescue IdNotAfiliadoError => e
    status 401
    body e.message

  rescue PrestacionNotExistsError, CentroInexistenteError, CentroNoContienePrestacionError => e
    status 404
    body e.message
  end
end
