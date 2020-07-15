require_relative '../../lib/version'

HealthAPI::App.controllers :version do
  get :index do
    {
      'version': Version.current
    }.to_json
  end
end
