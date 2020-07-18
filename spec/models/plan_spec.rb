require 'spec_helper'

describe 'Plan' do
  it 'deberia poder devolver el nombre con el que fue creado' do
    nombre = 'neo'
    costo = 500
    plan = Plan.new(nombre, costo)

    expect(plan.nombre).to eql nombre
  end

  it 'deberia poder devolver el costo con el que fue creado' do
    nombre = 'neo'
    costo = 500
    plan = Plan.new(nombre, costo)

    expect(plan.costo).to eql costo
  end
end
