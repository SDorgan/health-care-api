require_relative '../errors/not_available_in_production_error'
require_relative '../../lib/version'

HealthAPI::App.controllers :reset do
  post :index do
    halt 403 if request.env['HTTP_API_KEY'].nil? || !request.env['HTTP_API_KEY'].eql?(API_KEY)
    raise NotAvailableInProductionError if ENV['RACK_ENV'] == 'production'

    ENV['TEST_DATE'] = nil
    CompraMedicamentosRepository.new.delete_all
    VisitaMedicaRepository.new.delete_all
    AfiliadoRepository.new.delete_all
    PlanRepository.new.delete_all
    CentroRepository.new.delete_all
    PrestacionRepository.new.delete_all

    status 204
  rescue NotAvailableInProductionError => e
    status 405
    respuesta = { 'respuesta': 'error', 'mensaje': e.message }
    body respuesta.to_json
  end
end

HealthAPI::App.controllers :version do
  get :index do
    {
      'version': Version.current
    }.to_json
  end
end

HealthAPI::App.controllers :fecha do
  post :index do
    halt 403 if request.env['HTTP_API_KEY'].nil? || !request.env['HTTP_API_KEY'].eql?(API_KEY)
    raise NotAvailableInProductionError if ENV['RACK_ENV'] == 'production'

    params = JSON.parse(request.body.read)
    ENV['TEST_DATE'] = params['fecha']

    status 204
  rescue NotAvailableInProductionError
    status 405
    respuesta = { 'respuesta': 'error', 'mensaje': e.message }
    body respuesta.to_json
  end
end

HealthAPI::App.controllers :distancias do
  post :index do
    halt 403 if request.env['HTTP_API_KEY'].nil? || !request.env['HTTP_API_KEY'].eql?(API_KEY)
    raise NotAvailableInProductionError if ENV['RACK_ENV'] == 'production'

    params = JSON.parse(request.body.read)
    ENV['DISTANCIAS'] = params['respuesta'].to_json

    status 204
  rescue NotAvailableInProductionError
    status 405
    respuesta = { 'respuesta': 'error', 'mensaje': e.message }
    body respuesta.to_json
  end
end
