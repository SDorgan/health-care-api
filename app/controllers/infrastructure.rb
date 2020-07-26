require_relative '../errors/not_available_in_production_error'
require_relative '../../lib/version'

HealthAPI::App.controllers :reset do
  post :index do
    raise NotAvailableInProductionError if ENV['RACK_ENV'] == 'production'

    ENV['TEST_DATE'] = nil
    CompraMedicamentosRepository.new.delete_all
    VisitaMedicaRepository.new.delete_all
    AfiliadoRepository.new.delete_all
    PlanRepository.new.delete_all
    CentroRepository.new.delete_all
    PrestacionRepository.new.delete_all

    'ok'
  rescue NotAvailableInProductionError
    status 405
    'error'
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
    raise NotAvailableInProductionError if ENV['RACK_ENV'] == 'production'

    params = JSON.parse(request.body.read)
    ENV['TEST_DATE'] = params['fecha']

    'ok'
  rescue NotAvailableInProductionError
    status 405
    'error'
  end
end
