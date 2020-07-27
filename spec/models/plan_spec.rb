require 'spec_helper'
require_relative '../../app/errors/edad_maxima_supera_limite_error'
require_relative '../../app/errors/edad_minima_no_alcanza_limite_error'
require_relative '../../app/errors/no_se_admite_conyuge_error'
require_relative '../../app/errors/se_requiere_conyuge_error'

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

  let(:conyuge) do
    Plan.no_admite_conyuge
  end

  let(:requiere_conyuge) do
    Plan.requiere_conyuge
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

  it 'deberia poder devolver el metodo de conyuge que fue creado' do
    plan = Plan.new(nombre: nombre, costo: costo, cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos, edad_minima: edad_minima,
                    edad_maxima: edad_maxima, cantidad_hijos_maxima: cantidad_hijos_maxima,
                    conyuge: conyuge)

    expect(plan.conyuge).to eql conyuge
  end

  it 'deberia poder devolver el validar el plan con edad y conyuge' do
    plan = Plan.new(nombre: nombre, costo: costo, cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos, edad_minima: edad_minima,
                    edad_maxima: edad_maxima, cantidad_hijos_maxima: cantidad_hijos_maxima,
                    conyuge: conyuge)

    expect(plan.validar_plan_con(20, 0, false)).to be true
  end

  it 'deberia poder devolver error por superar limite de edad del plan' do
    plan = Plan.new(nombre: nombre, costo: costo, cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos, edad_minima: edad_minima,
                    edad_maxima: edad_maxima, cantidad_hijos_maxima: cantidad_hijos_maxima,
                    conyuge: conyuge)

    expect { plan.validar_plan_con(120, 0, false) }.to raise_error(EdadMaximaSuperaLimiteError)
  end

  it 'deberia poder devolver error por no alzancar limite de edad del plan' do
    plan = Plan.new(nombre: nombre, costo: costo, cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos, edad_minima: edad_minima,
                    edad_maxima: edad_maxima, cantidad_hijos_maxima: cantidad_hijos_maxima,
                    conyuge: conyuge)

    expect { plan.validar_plan_con(8, 0, false) }.to raise_error(EdadMinimaNoAlcanzaLimiteError)
  end

  it 'deberia poder devolver error por tener conyuge cuando el plan no lo admite' do
    plan = Plan.new(nombre: nombre, costo: costo, cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos, edad_minima: edad_minima,
                    edad_maxima: edad_maxima, cantidad_hijos_maxima: cantidad_hijos_maxima,
                    conyuge: conyuge)

    expect { plan.validar_plan_con(20, 0, true) }.to raise_error(NoSeAdmiteConyugeError)
  end

  it 'deberia poder devolver error por requerir conyuge cuando el plan requiere conyuge' do
    plan = Plan.new(nombre: nombre, costo: costo, cobertura_visitas: cobertura_visitas,
                    cobertura_medicamentos: cobertura_medicamentos, edad_minima: edad_minima,
                    edad_maxima: edad_maxima, cantidad_hijos_maxima: cantidad_hijos_maxima,
                    conyuge: requiere_conyuge)

    expect { plan.validar_plan_con(20, 0, false) }.to raise_error(SeRequiereConyugeError)
  end
end
