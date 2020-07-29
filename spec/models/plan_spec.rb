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
    0
  end

  let(:requiere_cantidad_hijos_maxima) do
    1
  end

  let(:conyuge) do
    Plan::NO_ADMITE_CONYUGE
  end

  let(:requiere_conyuge) do
    Plan::REQUIERE_CONYUGE
  end

  it 'deberia poder devolver el nombre con el que fue creado' do
    plan = Plan.new(nombre: nombre, costo: costo, cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos,
                    edad_minima: edad_minima, edad_maxima: edad_maxima)

    expect(plan.nombre).to eql nombre
  end

  it 'deberia poder devolver el costo con el que fue creado' do
    plan = Plan.new(nombre: nombre, costo: costo, cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos,
                    edad_minima: edad_minima, edad_maxima: edad_maxima)

    expect(plan.costo).to eql costo
  end

  it 'deberia poder devolver el limite de cobertura de visitas creado' do
    plan = Plan.new(nombre: nombre, costo: costo, cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos,
                    edad_minima: edad_minima, edad_maxima: edad_maxima)

    expect(plan.cobertura_visitas.cantidad).to eql cantidad_visitas
  end

  it 'deberia poder devolver la cantidad de copago creado' do
    plan = Plan.new(nombre: nombre, costo: costo, cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos,
                    edad_minima: edad_minima, edad_maxima: edad_maxima)

    expect(plan.cobertura_visitas.copago).to eql copago
  end

  it 'deberia poder devolver la cobertura a medicamentos con la que fue creado' do
    plan = Plan.new(nombre: nombre, costo: costo, cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos,
                    edad_minima: edad_minima, edad_maxima: edad_maxima)

    expect(plan.cobertura_medicamentos.porcentaje).to eql porcentaje_cobertura_medicamentos # rubocop:disable Metrics/LineLength
  end

  it 'deberia poder devolver la edad minima con la que fue creado' do
    plan = Plan.new(nombre: nombre, costo: costo, cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos,
                    edad_minima: edad_minima, edad_maxima: edad_maxima)

    expect(plan.edad_minima).to eql edad_minima
  end

  it 'deberia poder devolver la edad maxima con la que fue creado' do
    plan = Plan.new(nombre: nombre, costo: costo, cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos,
                    edad_minima: edad_minima, edad_maxima: edad_maxima)

    expect(plan.edad_maxima).to eql edad_maxima
  end

  it 'deberia poder devolver la cantidad de hijos con la que fue creado' do
    plan = Plan.new(nombre: nombre, costo: costo, cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos, edad_minima: edad_minima,
                    edad_maxima: edad_maxima, cantidad_hijos_maxima: cantidad_hijos_maxima)

    expect(plan.cantidad_hijos_maxima).to eql cantidad_hijos_maxima
  end

  it 'deberia poder devolver el metodo de conyuge que fue creado' do
    plan = Plan.new(nombre: nombre, costo: costo, cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos, edad_minima: edad_minima,
                    edad_maxima: edad_maxima, cantidad_hijos_maxima: cantidad_hijos_maxima,
                    conyuge: conyuge)

    expect(plan.conyuge).to eql conyuge
  end

  it 'deberia lanzar un error cuando no especifico un nombre' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
    expect do
      Plan.new(costo: costo, cobertura_visitas: cobertura_visitas,
               cobertura_medicamentos: cobertura_medicamentos, edad_minima: edad_minima,
               edad_maxima: edad_maxima, cantidad_hijos_maxima: cantidad_hijos_maxima,
               conyuge: conyuge)
    end.to raise_error(PlanSinNombreError)
  end

  it 'deberia lanzar un error cuando no especifico el costo' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
    expect do
      Plan.new(nombre: nombre, cobertura_visitas: cobertura_visitas,
               cobertura_medicamentos: cobertura_medicamentos, edad_minima: edad_minima,
               edad_maxima: edad_maxima, cantidad_hijos_maxima: cantidad_hijos_maxima,
               conyuge: conyuge)
    end.to raise_error(PlanSinCostoError)
  end

  it 'deberia lanzar un error cuando no especifico el limite maximo de edad' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
    expect do
      Plan.new(nombre: nombre, costo: costo,
               cobertura_visitas: cobertura_visitas,
               cobertura_medicamentos: cobertura_medicamentos,
               edad_minima: edad_minima,
               cantidad_hijos_maxima: cantidad_hijos_maxima,
               conyuge: conyuge)
    end.to raise_error(PlanSinRangoDeEdadesError)
  end
end
