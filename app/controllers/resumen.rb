require_relative '../errors/id_not_afiliado_error'

HealthAPI::App.controllers :resumen do
  get :index do
    id = request.params['id']
    from = request.params['from']
    repo_afiliados = if from.eql?('telegram')
                       BuscadorAfiliadoTelegram.new(AfiliadoRepository.new)
                     else
                       BuscadorAfiliadoApiExterna.new(AfiliadoRepository.new)
                     end

    resumen = Resumen.new(repo_afiliados.find(id),
                          PlanRepository.new,
                          VisitaMedicaRepository.new,
                          CompraMedicamentosRepository.new)

    resumen.generar

    ResumenResponseBuilder.create_from(resumen)

  rescue IdNotAfiliadoError => e
    status 401
    body e.message
  end
end
