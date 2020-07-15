HealthAPI::App.controllers :covid do
  post :index do
    params = JSON.parse(request.body.read)

    temperatura = params['temperatura'].to_i

    sospechoso = true
    sospechoso = false unless temperatura >= 37

    CovidResponseBuilder.create_from(sospechoso)
  end

  get :index, with: :afiliado_id do
    sospechoso = AfiliadoRepository.new.es_sospechoso(params[:afiliado_id])
    CovidResponseBuilder.create_from(sospechoso)
  end
end
