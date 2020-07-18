require 'spec_helper'

describe 'PrestacionDePlan' do
  let(:plan) do
    plan = Plan.new('Neo', 400)
    plan.id = 1

    plan
  end

  let(:prestacion) do
    prestacion = Prestacion.new('Traumatología', 1200)
    prestacion.id = 1

    prestacion
  end

  it 'deberia poder devolver los datos con los que fue creado' do
    prestacion_de_plan = PrestacionDePlan.new(plan, prestacion)

    expect(prestacion_de_plan.plan_id).to eql plan.id
    expect(prestacion_de_plan.prestacion_id).to eql prestacion.id
  end
end
