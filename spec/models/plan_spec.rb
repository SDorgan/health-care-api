require 'spec_helper'

describe 'Plan' do
  it 'deberia poder devolver el nombre con el que fue creado' do
    nombre = 'neo'
    plan = Plan.new(nombre)

    expect(plan.nombre).to eql nombre
  end
end
