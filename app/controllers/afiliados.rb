require_relative '../errors/plan_inexistente_error'

HealthAPI::App.controllers :afiliados do
  get :index do
    afiliados = AfiliadoRepository.new.all

    AfiliadoResponseBuilder.create_from_all(afiliados)
  end

  post :index do
    params = JSON.parse(request.body.read)
    registro = Registro.new(AfiliadoRepository.new, PlanRepository.new)
    afiliado = registro.registrar_afiliado(nombre_afiliado: params['nombre'],
                                           nombre_plan: params['nombre_plan'],
                                           id_telegram: params['id_telegram'],
                                           cantidad_hijos: params['cantidad_hijos'],
                                           edad: params['edad'],
                                           conyuge: params['conyuge'] || false)
    status 201

    AfiliadoResponseBuilder.create_from(afiliado)

  rescue PlanInexistenteError => e
    status 400
    body e.message
  end
end
