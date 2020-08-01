require 'spec_helper'

describe 'PrestacionesController' do
  it 'deberia devoler las prestaciones' do
    get '/prestaciones'
    last_response.body.include?('prestaciones')
  end

  it 'deberia devolver la prestación con la que se hizo POST' do
    post '/prestaciones', { 'nombre': 'Traumatología', 'costo': 1200 }.to_json
    last_response.body.include?('nombre')
    last_response.body.include?('costo')
  end

  it 'deberia devolver un error si no se especifica el costo' do
    post '/prestaciones', { 'nombre': 'Traumatología' }.to_json
    expect(last_response.status).to eq 400
  end
end
