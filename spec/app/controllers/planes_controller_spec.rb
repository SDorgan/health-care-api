require 'spec_helper'

describe 'PlanesController' do
  let(:nombre) do
    'PlanJuventud'
  end

  let(:costo) do
    500
  end

  let(:limite_cobertura_visitas) do
    4
  end

  let(:copago) do
    100
  end

  let(:body) do
    { 'nombre' => nombre,
      'costo' => costo,
      'limite_cobertura_visitas' => limite_cobertura_visitas,
      'copago' => copago }.to_json
  end

  it 'deberia devoler los planes' do
    get '/planes'
    last_response.body.include?('planes')
  end

  it 'deberia devolver el plan con el que se hizo POST' do
    post '/planes', body
    response = JSON.parse(last_response.body)
    expect(response['plan']['nombre']).to eq nombre
  end

  it 'deberia devolver el plan con costo con el que se hizo POST' do
    post '/planes', body
    response = JSON.parse(last_response.body)
    expect(response['plan']['costo']).to eq costo
  end

  it 'deberia devolver el plan con limite visitas con el que se hizo POST' do
    post '/planes', body
    response = JSON.parse(last_response.body)
    expect(response['plan']['limite_cobertura_visitas']).to eq limite_cobertura_visitas
  end

  it 'deberia devolver el plan con copago con el que se hizo POST' do
    post '/planes', body
    response = JSON.parse(last_response.body)
    expect(response['plan']['copago']).to eq copago
  end
end
