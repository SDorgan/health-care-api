require 'spec_helper'

describe 'AfiliadosController' do
  before(:each) do
    data = { 'nombre' => 'PlanJuventud', 'precio' => 100 }.to_json
    post '/planes', data
  end

  it 'deberia devoler los afiliados' do
    get '/afiliados'
    last_response.body.include?('afiliados')
  end

  it 'deberia devolver un id al crearse con un plan' do
    post '/afiliados', { 'nombre': 'Juan', 'nombre_plan': 'PlanJuventud' }.to_json
    last_response.body.include?('id')
  end
end
