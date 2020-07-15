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

  it 'deberia devolver el costo del plan guardado' do
    saved_plan = @repo.find(@plan.id)

    expect(saved_plan.costo).to eql @plan.costo
  end

  it 'deberia poder filtrar por nombre plan' do
    @repo.save(Plan.new('familiar', 200))
    plan_encontrado = @repo.find_plan(@plan.nombre)
    expect(plan_encontrado.id).to eql @plan.id
  end
end
