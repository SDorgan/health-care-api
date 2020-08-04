require File.expand_path(File.dirname(__FILE__) + '/../../config/boot')

require 'faraday'
require 'rack/test'
require 'simplecov'
require 'rspec/expectations'

BASE_URL = 'http://localhost:3000'.freeze

if ENV['BASE_URL']
  BASE_URL = ENV['BASE_URL']
else
  include Rack::Test::Methods

  def app
    Rack::Builder.new do
      map '/' do
        run HealthAPI::App
      end
    end
  end
end

SimpleCov.start do
  root(File.join(File.dirname(__FILE__), '..', '..'))
  coverage_dir 'reports/coverage'
  add_filter '/spec/'
  add_filter '/features/'
  add_filter '/admin/'
  add_filter '/db/'
  add_filter '/config/'
  add_group 'Models', 'domain/models'
  add_group 'Controllers', 'app/controllers'
  add_group 'Repositories', 'app/repositories'
end

Around do |_scenario, block|
  DB.transaction(rollback: :always, auto_savepoint: true) { block.call }
end

PRESTACIONES_URL = BASE_URL + '/prestaciones'
PLANES_URL = BASE_URL + '/planes'
CENTROS_URL = BASE_URL + '/centros'
RESET_URL = BASE_URL + '/reset'
AFILIADOS_URL = BASE_URL + '/afiliados'
VERSION_URL = BASE_URL + '/version'
COVID_URL = BASE_URL + '/covid'
VISITAS_URL = BASE_URL + '/visitas'
RESUMEN_URL = BASE_URL + '/resumen'
MEDICAMENTOS_URL = BASE_URL + '/medicamentos'
