require 'spec_helper'

describe 'PlanesController' do
  it 'deberia devoler los planes' do
    get '/planes'
    last_response.body.include?('planes')
  end

  it 'deberia devolver el plan con el que se hizo POST' do
    post '/planes', { 'nombre': 'neo' }.to_json
    last_response.body.include?('nombre')
  end

  it 'deberia devolver el plan con costo con el que se hizo POST' do
    data = { 'nombre' => 'neo', 'precio' => 100 }.to_json
    post '/planes', data
    last_response.body.include?('precio')
  end
end
