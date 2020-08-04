RACK_ENV = 'test'.freeze unless defined?(RACK_ENV)

require File.expand_path(File.dirname(__FILE__) + '/../config/boot')
Dir[File.expand_path(File.dirname(__FILE__) + '/../app/controllers/**/*.rb')].each(&method(:require))
Dir[File.expand_path(File.dirname(__FILE__) + '/../app/repositories/**/*.rb')].each(&method(:require))
Dir[File.expand_path(File.dirname(__FILE__) + '/../domain/**/*.rb')].each(&method(:require))

require 'simplecov'

SimpleCov.start do
  root(File.join(File.dirname(__FILE__), '..'))
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

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include Capybara

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  conf.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end
end

def app
  HealthAPI::App.tap { |app| }
  HealthAPI::App.set :protect_from_csrf, false
end
