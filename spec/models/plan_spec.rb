require 'spec_helper'

describe 'Plan' do
  let(:nombre) do
    'neo'
  end

  let(:costo) do
    500
  end

  let(:limite_cobertura_visitas) do
    4
  end

  let(:copago) do
    100
  end

  it 'deberia poder devolver el nombre con el que fue creado' do
    plan = Plan.new(nombre, costo, limite_cobertura_visitas, copago)

    expect(plan.nombre).to eql nombre
  end

  it 'deberia poder devolver el costo con el que fue creado' do
    plan = Plan.new(nombre, costo, limite_cobertura_visitas, copago)

    expect(plan.costo).to eql costo
  end

  it 'deberia poder devolver el limite de cobertura de visitas creado' do
    plan = Plan.new(nombre, costo, limite_cobertura_visitas, copago)

    expect(plan.limite_cobertura_visitas).to eql limite_cobertura_visitas
  end

  it 'deberia poder devolver la cantidad de copago creado' do
    plan = Plan.new(nombre, costo, limite_cobertura_visitas, copago)

    expect(plan.copago).to eql copago
  end
end
