HealthAPI::App.controllers :resumen do
  before do
    halt 403 if request.env['HTTP_API_KEY'].nil? || !request.env['HTTP_API_KEY'].eql?(API_KEY)
  end

  get :index do
    id_telegram = request.params['id']

    service = ResumenService.new(AfiliadoRepository.new,
                                 VisitaMedicaRepository.new,
                                 CompraMedicamentosRepository.new)

    resumen = service.generar(id_telegram)

    ResumenResponseBuilder.create_from(resumen)

  rescue UsuarioNoAfiliadoError => e
    status 401
    respuesta = { 'respuesta': 'error', 'mensaje': e.message }
    body respuesta.to_json
  end
end
