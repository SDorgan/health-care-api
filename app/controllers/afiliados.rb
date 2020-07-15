HealthAPI::App.controllers :afiliados do
  get :index do
    afiliados = AfiliadoRepository.new.all

    AfiliadoResponseBuilder.create_from_all(afiliados)
  end
end
