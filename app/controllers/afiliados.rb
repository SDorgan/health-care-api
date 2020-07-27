require_relative '../errors/plan_inexistente_error'
require_relative '../errors/edad_maxima_supera_limite_error'
require_relative '../errors/edad_minima_no_alcanza_limite_error'
require_relative '../errors/no_se_admite_conyuge_error'

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
  rescue EdadMaximaSuperaLimiteError => e
    status 400
    body e.message
  rescue EdadMinimaNoAlcanzaLimiteError => e
    status 400
    body e.message
  rescue NoSeAdmiteConyugeError => e
    status 400
    body e.message
  end
end
