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
    30
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

  let(:body_sin_edad_maxima) do
    { 'nombre' => nombre,
      'costo' => costo,
      'limite_cobertura_visitas' => limite_cobertura_visitas,
      'copago' => copago,
      'cobertura_medicamentos' => cobertura_medicamentos,
      'edad_minima' => edad_minima,
      'cantidad_hijos_maxima' => cantidad_hijos_maxima,
      'conyuge' => conyuge }.to_json
  end

  let(:body_sin_costo) do
    { 'nombre' => nombre,
      'limite_cobertura_visitas' => limite_cobertura_visitas,
      'copago' => copago,
      'cobertura_medicamentos' => cobertura_medicamentos,
      'edad_minima' => edad_minima,
      'edad_maxima' => edad_maxima,
      'cantidad_hijos_maxima' => cantidad_hijos_maxima,
      'conyuge' => conyuge }.to_json
  end

  let(:body_sin_nombre) do
    { 'costo' => costo,
      'limite_cobertura_visitas' => limite_cobertura_visitas,
      'copago' => copago,
      'cobertura_medicamentos' => cobertura_medicamentos,
      'edad_minima' => edad_minima,
      'edad_maxima' => edad_maxima,
      'cantidad_hijos_maxima' => cantidad_hijos_maxima,
      'conyuge' => conyuge }.to_json
  end

  it 'deberia devoler los planes' do
    get '/planes', {}, 'HTTP_API_KEY' => API_KEY
    last_response.body.include?('planes')
  end

  it 'deberia devolver el plan con el que se hizo POST' do
    post '/planes', body, 'HTTP_API_KEY' => API_KEY
    response = JSON.parse(last_response.body)
    expect(response['plan']['nombre']).to eq nombre
  end

  it 'deberia devolver el plan con costo con el que se hizo POST' do
    post '/planes', body, 'HTTP_API_KEY' => API_KEY
    response = JSON.parse(last_response.body)
    expect(response['plan']['costo']).to eq costo
  end

  it 'deberia devolver el plan con limite visitas con el que se hizo POST' do
    post '/planes', body, 'HTTP_API_KEY' => API_KEY
    response = JSON.parse(last_response.body)
    expect(response['plan']['limite_cobertura_visitas']).to eq limite_cobertura_visitas
  end

  it 'deberia devolver el plan con copago con el que se hizo POST' do
    post '/planes', body, 'HTTP_API_KEY' => API_KEY
    response = JSON.parse(last_response.body)
    expect(response['plan']['copago']).to eq copago
  end

  it 'deberia devolver la cobertura de medicamentos con la que se hizo POST' do
    post '/planes', body, 'HTTP_API_KEY' => API_KEY
    response = JSON.parse(last_response.body)
    expect(response['plan']['cobertura_medicamentos']).to eq cobertura_medicamentos
  end

  it 'deberia devolver la edad minima y maxima con la que se hizo POST' do
    post '/planes', body, 'HTTP_API_KEY' => API_KEY
    response = JSON.parse(last_response.body)
    expect(response['plan']['edad_minima']).to eq edad_minima
    expect(response['plan']['edad_maxima']).to eq edad_maxima
  end

  it 'deberia devolver la cantidad maxima de hijos con la que se hizo POST' do
    post '/planes', body, 'HTTP_API_KEY' => API_KEY
    response = JSON.parse(last_response.body)
    expect(response['plan']['cantidad_hijos_maxima']).to eq cantidad_hijos_maxima
  end

  it 'deberia devolver estado civil con la que se hizo POST' do
    post '/planes', body, 'HTTP_API_KEY' => API_KEY
    response = JSON.parse(last_response.body)
    expect(response['plan']['conyuge']).to eq conyuge
  end

  it 'deberia lanzar un error cuando no se especifica el nombre' do
    post '/planes', body_sin_nombre, 'HTTP_API_KEY' => API_KEY
    expect(last_response.status).to eq 400
  end

  it 'deberia lanzar un error cuando no se especifica el costo' do
    post '/planes', body_sin_costo, 'HTTP_API_KEY' => API_KEY
    expect(last_response.status).to eq 400
  end

  it 'deberia lanzar un error cuando no se especifica la edad máxima' do
    post '/planes', body_sin_edad_maxima, 'HTTP_API_KEY' => API_KEY
    expect(last_response.status).to eq 400
  end

  it 'deberia poder pedir por un plan individual por nombre' do
    post '/planes', body, 'HTTP_API_KEY' => API_KEY
    get "/planes?nombre=#{ERB::Util.url_encode(nombre)}", {}, 'HTTP_API_KEY' => API_KEY
    response = JSON.parse(last_response.body)
    plan = response['plan']
    expect(plan['nombre']). to eq nombre
  end

  it 'deberia tener error si pido por un plan que no existe' do
    get '/planes?nombre=PlanQueNoExiste', {}, 'HTTP_API_KEY' => API_KEY
    expect(last_response.status).to eq 404
    expect(last_response.body).to eq 'El plan es inexistente'
  end
end
