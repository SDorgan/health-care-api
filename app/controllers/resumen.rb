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

    raise IdNotAfiliadoError unless repo_afiliados.exists_afiliado_with_id(id)

    resumen = Resumen.new(repo_afiliados.find(id),
                          PlanRepository.new,
                          VisitaMedicaRepository.new,
                          CompraMedicamentosRepository.new)

    resumen.generar

    ResumenResponseBuilder.create_from(resumen)

  rescue IdNotAfiliadoError
    status 401
    'El ID no pertenece a un afiliado'
  end
end
