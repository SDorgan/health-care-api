require 'spec_helper'

describe 'App' do
  before(:each) do
    @nombre_plan = 'PlanJuventud'
    @costo_plan = 100
    @limite_visita_plan = 3
    @cobertura_medicamentos = 80
    @copago = 3
    @edad_minima = 10
    @edad_maxima = 60
    @cantidad_hijos = 0
    @conyuge = false
    data = { 'nombre' => @nombre_plan,
             'costo' => @costo_plan,
             'limite_cobertura_visitas' => @limite_visita_plan,
             'cobertura_medicamentos' => @cobertura_medicamentos,
             'copago' => @copago,
             'cantidad_hijos_maxima' => @cantidad_hijos,
             'edad_minima' => @edad_minima,
             'edad_maxima' => @edad_maxima,
             'conyuge' => @conyuge }.to_json
    post '/planes', data, 'HTTP_API_KEY' => API_KEY
    @plan_repository = PlanRepository.new
  end

  it 'deberia guardarse el plan ingresado' do
    planes = @plan_repository.all
    expect(planes.length).to be 1
  end
  # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
  it 'deberia guardarse el afiliado ingresado junto con su plan' do
    plan = @plan_repository.all.first
    plan_id = plan.id
    afiliado_repository = AfiliadoRepository.new
    post '/afiliados', { 'nombre': 'Juan', 'nombre_plan': 'PlanJuventud',
                         'cantidad_hijos': 0, 'edad': 18, 'conyuge': false }.to_json, 'HTTP_API_KEY' => API_KEY
    afiliados = afiliado_repository.all
    expect(afiliados.first.nombre).to eql 'Juan'
    expect(afiliados.first.plan.id).to eql plan_id
  end

  it 'deberia guardarse el afiliado con plan y id telegram' do
    plan = @plan_repository.all.first
    plan_id = plan.id
    id_telegram = '24'
    afiliado_repository = AfiliadoRepository.new
    post '/afiliados', { 'nombre': 'Juan', 'nombre_plan': 'PlanJuventud',
                         'cantidad_hijos': 0, 'edad': 18, 'conyuge': false,
                         'id_telegram': id_telegram }.to_json, 'HTTP_API_KEY' => API_KEY
    afiliados = afiliado_repository.all
    expect(afiliados.first.nombre).to eql 'Juan'
    expect(afiliados.first.plan.id).to eql plan_id
    expect(afiliados.first.id_telegram).to eql id_telegram
  end

  it 'deberia devolver el plan guardado' do # rubocop:disable RSpec/MultipleExpectations
    get 'planes', {}, 'HTTP_API_KEY' => API_KEY
    response = JSON.parse(last_response.body)
    plan = response['planes'].first
    expect(plan['nombre']).to eql @nombre_plan
    expect(plan['costo']).to eql @costo_plan
    expect(plan['limite_cobertura_visitas']).to eql @limite_visita_plan
    expect(plan['copago']).to eql @copago
  end
  # rubocop:enable RSpec/ExampleLength, Metrics/LineLength

  it 'deberia devolver 403 cuando se manda sin header api key' do
    get 'planes'
    expect(last_response.status).to be 403
  end
end
