require_relative '../errors/not_available_in_production_error'

HealthAPI::App.controllers :reset do
  post :index do
    raise NotAvailableInProductionError if ENV['RACK_ENV'] == 'production'

    PlanRepository.new.delete_all
    PrestacionRepository.new.delete_all

    'ok'
  rescue NotAvailableInProductionError
    status 405
    'error'
  end
end
