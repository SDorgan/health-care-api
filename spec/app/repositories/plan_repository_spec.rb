require 'integration_spec_helper'

describe 'PlanRepository' do
  it 'deberia guardar el plan generando un id positivo' do
    nombre = 'neo'
    plan = Plan.new(nombre)

    plan_id = PlanRepository.new.save(plan)

    expect(plan_id).to be_positive
  end

  it 'deberia encontrar el plan luego de haberse guardado' do
    plan = Plan.new('neo')
    repo = PlanRepository.new

    plan_id = repo.save(plan)

    saved_plan = repo.find(plan_id)

    expect(saved_plan.nombre).to eql plan.nombre
  end
end
