HealthAPI::App.controllers :resumen do
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
