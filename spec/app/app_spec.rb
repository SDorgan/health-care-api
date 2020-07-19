require 'spec_helper'

describe 'App' do
  before(:each) do
    @nombre_plan = 'PlanJuventud'
    @costo_plan = 100
    @limite_visita_plan = 3
    data = { 'nombre' => @nombre_plan,
             'costo' => @costo_plan,
             'limite_cobertura_visitas' => @limite_visita_plan }.to_json
    post '/planes', data
    @plan_repository = PlanRepository.new
  end

  it 'deberia guardarse el plan ingresado' do
    planes = @plan_repository.all
    expect(planes.length).to be 1
  end
  # rubocop:disable RSpec/ExampleLength
  it 'deberia guardarse el afiliado ingresado junto con su plan' do
    plan = @plan_repository.all.first
    plan_id = plan.id
    afiliado_repository = AfiliadoRepository.new
    post '/afiliados', { 'nombre': 'Juan', 'nombre_plan': 'PlanJuventud' }.to_json
    afiliados = afiliado_repository.all
    expect(afiliados.first.nombre).to eql 'Juan'
    expect(afiliados.first.plan_id).to eql plan_id
  end

  it 'deberia guardarse el afiliado con plan y id telegram' do
    plan = @plan_repository.all.first
    plan_id = plan.id
    id_telegram = '24'
    afiliado_repository = AfiliadoRepository.new
    post '/afiliados', { 'nombre': 'Juan', 'nombre_plan': 'PlanJuventud', 'id_telegram': id_telegram }.to_json
    afiliados = afiliado_repository.all
    expect(afiliados.first.nombre).to eql 'Juan'
    expect(afiliados.first.plan_id).to eql plan_id
    expect(afiliados.first.id_telegram).to eql id_telegram
  end

  it 'deberia devolver el plan guardado' do
    get 'planes'
    response = JSON.parse(last_response.body)
    plan = response['planes'].first
    expect(plan['nombre']).to eql @nombre_plan
    expect(plan['costo']).to eql @costo_plan
    expect(plan['limite_cobertura_visitas']).to eql @limite_visita_plan
  end
  # rubocop:enable RSpec/ExampleLength
end
