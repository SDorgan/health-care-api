require 'spec_helper'

describe 'Plan' do
  it 'deberia poder devolver el nombre con el que fue creado' do
    nombre = 'neo'
    precio = 500
    plan = Plan.new(nombre, precio)

    expect(plan.nombre).to eql nombre
  end

  it 'deberia poder devolver el precio con el que fue creado' do
    nombre = 'neo'
    precio = 500
    plan = Plan.new(nombre, precio)

    expect(plan.precio).to eql precio
  end
end
