require_relative '../../domain/errors/registracion_error'

HealthAPI::App.controllers :afiliados do
  before do
    halt 403 if request.env['HTTP_API_KEY'].nil? || !request.env['HTTP_API_KEY'].eql?(API_KEY)
  end

  get :index do
    afiliados = AfiliadoRepository.new.all

    AfiliadoResponseBuilder.create_from_all(afiliados)
  end

  head :index, with: :id_telegram do
    exists = AfiliadoRepository.new.exists_afiliado_with_telegram_id(params[:id_telegram])

    if exists
      status 200
    else
      status 404
    end
  end

  post :index do
    params = JSON.parse(request.body.read)

    service = AfiliadoService.new(AfiliadoRepository.new, PlanRepository.new)

    afiliado = service.registrar(nombre_afiliado: params['nombre'],
                                 nombre_plan: params['nombre_plan'],
                                 id_telegram: params['id_telegram'],
                                 cantidad_hijos: params['cantidad_hijos'],
                                 edad: params['edad'],
                                 conyuge: params['conyuge'] || false)
    status 201

    AfiliadoResponseBuilder.create_from(afiliado)

  rescue RegistracionError => e
    status 400
    respuesta = { 'respuesta': 'error', 'mensaje': e.message }
    body respuesta.to_json
  end
end
