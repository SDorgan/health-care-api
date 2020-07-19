require 'spec_helper'

describe 'PlanesController' do
  it 'deberia devoler los planes' do
    get '/planes'
    last_response.body.include?('planes')
  end

  it 'deberia devolver el plan con el que se hizo POST' do
    nombre = 'neo'
    post '/planes', { 'nombre': nombre, 'costo' => 100, 'limite_cobertura_visitas' => 3 }.to_json
    response = JSON.parse(last_response.body)
    expect(response['plan']['nombre']).to eq nombre
  end

  it 'deberia devolver el plan con costo con el que se hizo POST' do
    costo = 100
    data = { 'nombre' => 'neo', 'costo' => costo, 'limite_cobertura_visitas' => 3 }.to_json
    post '/planes', data
    response = JSON.parse(last_response.body)
    expect(response['plan']['costo']).to eq costo
  end
  it 'deberia devolver el plan con limite visitas con el que se hizo POST' do
    limite_visitas = 4
    data = { 'nombre' => 'neo', 'costo' => 100, 'limite_cobertura_visitas' => limite_visitas }.to_json # rubocop:disable Metrics/LineLength
    post '/planes', data
    response = JSON.parse(last_response.body)
    expect(response['plan']['limite_cobertura_visitas']).to eq limite_visitas
  end
end
