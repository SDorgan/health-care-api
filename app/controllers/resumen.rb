HealthAPI::App.controllers :resumen do
  get :index do
    # se obtienen los query params
    # id: integer
    # from: string {telegram, etc}

    id = request.params['id']
    from = request.params['from']

    buscador = if from.eql?('telegram')
                 BuscadorAfiliadoTelegram.new(AfiliadoRepository.new)
               else
                 BuscadorAfiliadoApiExterna.new(AfiliadoRepository.new)
               end

    afiliado = buscador.find(id)

    plan = PlanRepository.new.find(afiliado.plan_id)

    visitas = VisitaMedicaRepository.new.find_by_afiliado(afiliado.id)

    resumen = Resumen.new(afiliado, plan, visitas)

    ResumenResponseBuilder.create_from(resumen)
  end
end
