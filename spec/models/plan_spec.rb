require 'spec_helper'

describe 'Plan' do
  let(:nombre) do
    'neo'
  end

  let(:costo) do
    500
  end

  let(:cantidad_visitas) do
    4
  end

  let(:copago) do
    100
  end

  let(:porcentaje_cobertura_medicamentos) do
    30
  end

  let(:cobertura_visitas) do
    CoberturaVisita.new(cantidad_visitas, copago)
  end

  let(:cobertura_medicamentos) do
    CoberturaMedicamentos.new(porcentaje_cobertura_medicamentos)
  end

  let(:edad_minima) do
    15
  end

  let(:edad_maxima) do
    100
  end

  let(:cantidad_hijos_maxima) do
    3
  end

  it 'deberia poder devolver el nombre con el que fue creado' do
    plan = Plan.new(nombre: nombre, costo: costo, cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos, edad_minima: edad_minima)

    expect(plan.nombre).to eql nombre
  end

  it 'deberia poder devolver el costo con el que fue creado' do
    plan = Plan.new(nombre: nombre, costo: costo, cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos, edad_minima: edad_minima)

    expect(plan.costo).to eql costo
  end

  it 'deberia poder devolver el limite de cobertura de visitas creado' do
    plan = Plan.new(nombre: nombre, costo: costo, cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos, edad_minima: edad_minima)

    expect(plan.cobertura_visitas.cantidad).to eql cantidad_visitas
  end

  it 'deberia poder devolver la cantidad de copago creado' do
    plan = Plan.new(nombre: nombre, costo: costo, cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos, edad_minima: edad_minima)

    expect(plan.cobertura_visitas.copago).to eql copago
  end

  it 'deberia poder devolver la cobertura a medicamentos con la que fue creado' do
    plan = Plan.new(nombre: nombre, costo: costo, cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos, edad_minima: edad_minima)

    expect(plan.cobertura_medicamentos.porcentaje).to eql porcentaje_cobertura_medicamentos # rubocop:disable Metrics/LineLength
  end

  it 'deberia poder devolver la edad minima con la que fue creado' do
    plan = Plan.new(nombre: nombre, costo: costo, cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos, edad_minima: edad_minima)

    expect(plan.edad_minima).to eql edad_minima
  end

  it 'deberia poder devolver la edad maxima con la que fue creado' do
    plan = Plan.new(nombre: nombre, costo: costo, cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos, edad_minima: edad_minima,
                    edad_maxima: edad_maxima)

    expect(plan.edad_maxima).to eql edad_maxima
  end

  it 'deberia poder devolver la cantidad de hijos con la que fue creado' do
    plan = Plan.new(nombre: nombre, costo: costo, cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos, edad_minima: edad_minima,
                    edad_maxima: edad_maxima, cantidad_hijos_maxima: cantidad_hijos_maxima)

    expect(plan.cantidad_hijos_maxima).to eql cantidad_hijos_maxima
  end
end
