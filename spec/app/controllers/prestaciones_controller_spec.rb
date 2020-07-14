require 'spec_helper'

describe 'PrestacionesController' do
  xit 'deberia devoler las prestaciones' do
    get '/prestaciones'
    last_response.body.include?('prestaciones')
  end

  xit 'deberia devolver la prestación con la que se hizo POST' do
    post '/prestaciones', { 'nombre': 'Traumatología', 'costo': 1200 }.to_json
    last_response.body.include?('nombre')
    last_response.body.include?('costo')
  end
end
