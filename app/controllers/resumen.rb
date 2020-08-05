HealthAPI::App.controllers :resumen do
  before do
    halt 403 if request.env['HTTP_API_KEY'].nil? || !request.env['HTTP_API_KEY'].eql?(API_KEY)
  end

  get :index do
    id_telegram = request.params['id']

    afiliado = AfiliadoRepository.new.find_by_telegram_id(id_telegram)

    resumen = Resumen.new(afiliado,
                          VisitaMedicaRepository.new,
                          CompraMedicamentosRepository.new)

    resumen.generar

    ResumenResponseBuilder.create_from(resumen)

  rescue AfiliadoNoEncontrado => e
    status 401
    body e.message
  end
end
