require_relative '../errors/id_not_afiliado_error'

HealthAPI::App.controllers :resumen do
  get :index do
    id_telegram = request.params['id']
    repo_afiliados = AfiliadoRepository.new
    resumen = Resumen.new(repo_afiliados.find_by_telegram_id(id_telegram),
                          VisitaMedicaRepository.new,
                          CompraMedicamentosRepository.new)

    resumen.generar

    ResumenResponseBuilder.create_from(resumen)

  rescue IdNotAfiliadoError => e
    status 401
    body e.message
  end
end
