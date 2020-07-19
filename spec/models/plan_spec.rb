require 'spec_helper'

describe 'Plan' do
  it 'deberia poder devolver el nombre con el que fue creado' do
    nombre = 'neo'
    costo = 500
    limite_cobertura_visitas = 4
    plan = Plan.new(nombre, costo, limite_cobertura_visitas)

    expect(plan.nombre).to eql nombre
  end

  it 'deberia poder devolver el costo con el que fue creado' do
    nombre = 'neo'
    costo = 500
    limite_cobertura_visitas = 4
    plan = Plan.new(nombre, costo, limite_cobertura_visitas)

    expect(plan.costo).to eql costo
  end

  it 'deberia poder devolver el limite de cobertura de visitas creado' do
    nombre = 'neo'
    costo = 500
    limite_cobertura_visitas = 4
    plan = Plan.new(nombre, costo, limite_cobertura_visitas)

    expect(plan.limite_cobertura_visitas).to eql limite_cobertura_visitas
  end
end
