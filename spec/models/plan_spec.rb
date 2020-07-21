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

  let(:cobertura_visitas) do
    CoberturaVisita.new(limite_cobertura_visitas)
  end

  let(:copago) do
    100
  end

  let(:cobertura_medicamentos) do
    30
  end

  it 'deberia poder devolver el nombre con el que fue creado' do
    plan = Plan.new(nombre, costo, copago,
                    cobertura_medicamentos, cobertura_visitas)

    expect(plan.nombre).to eql nombre
  end

  it 'deberia poder devolver el costo con el que fue creado' do
    plan = Plan.new(nombre, costo, copago,
                    cobertura_medicamentos, cobertura_visitas)

    expect(plan.costo).to eql costo
  end

  it 'deberia poder devolver el limite de cobertura de visitas creado' do
    plan = Plan.new(nombre, costo, copago,
                    cobertura_medicamentos, cobertura_visitas)

    expect(plan.cobertura_visitas.cantidad).to eql limite_cobertura_visitas
  end

  it 'deberia poder devolver la cantidad de copago creado' do
    plan = Plan.new(nombre, costo, copago,
                    cobertura_medicamentos, cobertura_visitas)

    expect(plan.copago).to eql copago
  end

  it 'deberia poder devolver la cobertura a medicamentos con la que fue creado' do
    plan = Plan.new(nombre, costo, copago,
                    cobertura_medicamentos, cobertura_visitas)

    expect(plan.cobertura_medicamentos).to eql cobertura_medicamentos
  end
end
