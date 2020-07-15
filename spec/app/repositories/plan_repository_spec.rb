require 'integration_spec_helper'

describe 'PlanRepository' do
  before(:each) do
    @plan = Plan.new('neo', 100)
    @repo = PlanRepository.new

    @plan = @repo.save(@plan)
  end

  it 'deberia guardar el plan generando un id positivo' do
    expect(@plan.id).to be_positive
  end

  it 'deberia encontrar el plan luego de haberse guardado' do
    saved_plan = @repo.find(@plan.id)

    expect(saved_plan.nombre).to eql @plan.nombre
  end

  it 'deberia devolver el plan existente cuando se solicitan todos los planes' do
    planes = @repo.all

    expect(planes.length).to be 1
    expect(planes.first.id).to eq @plan.id
  end

  it 'deberia devolver todos los planes disponibles' do
    @repo.save(Plan.new('familiar', 100))

    planes = @repo.all

    expect(planes.length).to be 2
  end

  it 'deberia devolver el precio del plan guardado' do
    saved_plan = @repo.find(@plan.id)

    expect(saved_plan.precio).to eql @plan.precio
  end
end
