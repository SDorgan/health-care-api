require 'integration_spec_helper'

describe 'PlanRepository' do
  it 'deberia guardar el plan generando un id positivo' do
    nombre = 'neo'
    plan = Plan.new(nombre)

    plan_id = PlanRepository.new.save(plan)

    expect(plan_id).to be_positive
  end
end
