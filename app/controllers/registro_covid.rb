HealthAPI::App.controllers :covid do
  before do
    halt 403 if request.env['HTTP_API_KEY'].nil? || !request.env['HTTP_API_KEY'].eql?(API_KEY)
  end
  post :index do
    params = JSON.parse(request.body.read)
    @repo = AfiliadoRepository.new
    afiliado = @repo.find_by_telegram_id(params['id_telegram'])
    afiliado.covid_sospechoso = true
    afiliado = @repo.save(afiliado)

    CovidResponseBuilder.create_from(afiliado.covid_sospechoso)
  end

  get :index, with: :afiliado_id do
    sospechoso = AfiliadoRepository.new.es_sospechoso(params[:afiliado_id])
    CovidResponseBuilder.create_from(sospechoso)
  end
end
