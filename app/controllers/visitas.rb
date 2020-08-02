require_relative '../errors/id_not_afiliado_error'
require_relative '../errors/prestacion_not_exists_error'
require_relative '../errors/centro_inexistente_error'
require_relative '../errors/centro_no_contiene_prestacion_error'

HealthAPI::App.controllers :visitas do
  post :index do
    params = JSON.parse(request.body.read)

    afiliado_id = params['afiliado']
    prestacion_id = params['prestacion']
    centro_id = params['centro']

    registro = RegistroVisita.new(AfiliadoRepository.new,
                                  PrestacionRepository.new,
                                  CentroRepository.new,
                                  VisitaMedicaRepository.new)

    visita_medica = registro.registrar(afiliado_id, prestacion_id, centro_id)

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
