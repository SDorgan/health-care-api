require 'integration_spec_helper'

describe 'PlanRepository' do
  before(:each) do
    @plan = Plan.new('neo')
    @repo = PlanRepository.new

    @plan_id = @repo.save(@plan)
  end

  it 'deberia guardar el plan generando un id positivo' do
    expect(@plan_id).to be_positive
  end

  it 'deberia encontrar el plan luego de haberse guardado' do
    saved_plan = @repo.find(@plan_id)

    expect(saved_plan.nombre).to eql @plan.nombre
  end

  it 'deberia devolver el plan existente cuando se solicitan todos los planes' do
    planes = @repo.all

    expect(planes.length).to be 1
    expect(planes.first.id).to eq @plan_id
  end

  it 'deberia devolver todos los planes disponibles' do
    @repo.save(Plan.new('familiar'))

    planes = @repo.all

    expect(planes.length).to be 2
  end
end
