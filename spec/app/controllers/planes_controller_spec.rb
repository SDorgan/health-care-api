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

  let(:cobertura_medicamentos) do
    30
  end

  let(:edad_minima) do
    10
  end

  let(:edad_maxima) do
    10
  end

  let(:cantidad_hijos_maxima) do
    1
  end

  let(:conyuge) do
    Plan::NO_ADMITE_CONYUGE
  end

  let(:body) do
    { 'nombre' => nombre,
      'costo' => costo,
      'limite_cobertura_visitas' => limite_cobertura_visitas,
      'copago' => copago,
      'cobertura_medicamentos' => cobertura_medicamentos,
      'edad_minima' => edad_minima,
      'edad_maxima' => edad_maxima,
      'cantidad_hijos_maxima' => cantidad_hijos_maxima,
      'conyuge' => conyuge }.to_json
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

  it 'deberia devolver la cobertura de medicamentos con la que se hizo POST' do
    post '/planes', body
    response = JSON.parse(last_response.body)
    expect(response['plan']['cobertura_medicamentos']).to eq cobertura_medicamentos
  end

  it 'deberia devolver la edad minima y maxima con la que se hizo POST' do
    post '/planes', body
    response = JSON.parse(last_response.body)
    expect(response['plan']['edad_minima']).to eq edad_minima
    expect(response['plan']['edad_maxima']).to eq edad_maxima
  end

  it 'deberia devolver la cantidad maxima de hijos con la que se hizo POST' do
    post '/planes', body
    response = JSON.parse(last_response.body)
    expect(response['plan']['cantidad_hijos_maxima']).to eq cantidad_hijos_maxima
  end

  it 'deberia devolver estado civil con la que se hizo POST' do
    post '/planes', body
    response = JSON.parse(last_response.body)
    expect(response['plan']['conyuge']).to eq conyuge
  end
end
