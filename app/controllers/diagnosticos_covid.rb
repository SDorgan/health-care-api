HealthAPI::App.controllers :covid do
  post :index do
    params = JSON.parse(request.body.read)

    temperatura = params['temperatura'].to_i

    return CovidResponseBuilder.create_from(false) unless temperatura >= 37

    @repo = AfiliadoRepository.new
    afiliado = @repo.find(params['afiliado'])
    afiliado.covid_sospechoso = true
    @repo.save(afiliado)

    CovidResponseBuilder.create_from(true)
  end

  get :index, with: :afiliado_id do
    sospechoso = AfiliadoRepository.new.es_sospechoso(params[:afiliado_id])
    CovidResponseBuilder.create_from(sospechoso)
  end
end
