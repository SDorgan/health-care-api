require_relative '../errors/not_available_in_production_error'
require_relative '../../lib/version'

HealthAPI::App.controllers :reset do
  post :index do
    raise NotAvailableInProductionError if ENV['RACK_ENV'] == 'production'

    PrestacionDeCentroRepository.new.delete_all
    PrestacionDePlanRepository.new.delete_all
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
