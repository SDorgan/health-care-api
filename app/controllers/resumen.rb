HealthAPI::App.controllers :resumen do
  get :index do
    id = request.params['id']
    from = request.params['from']

    repo_afiliados = if from.eql?('telegram')
                       BuscadorAfiliadoTelegram.new(AfiliadoRepository.new)
                     else
                       BuscadorAfiliadoApiExterna.new(AfiliadoRepository.new)
                     end

    consulta = ConsultaResumen.new(repo_afiliados,
                                   PlanRepository.new,
                                   VisitaMedicaRepository.new)

    resumen = consulta.generar_resumen(id)

    ResumenResponseBuilder.create_from(resumen)
  end
end
