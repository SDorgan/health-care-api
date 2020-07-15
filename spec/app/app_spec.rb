require 'spec_helper'

describe 'App' do
  before(:each) do
    data = { 'nombre' => 'PlanJuventud', 'precio' => 100 }.to_json
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
    id_plan = plan.id
    afiliado_repository = AfiliadoRepository.new
    post '/afiliados', { 'nombre': 'Juan', 'nombre_plan': 'PlanJuventud' }.to_json
    afiliados = afiliado_repository.all
    expect(afiliados.first.nombre).to eql 'Juan'
    expect(afiliados.first.id_plan).to eql id_plan
  end
  # rubocop:enable RSpec/ExampleLength
end
