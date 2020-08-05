require 'integration_spec_helper'

describe 'PlanRepository' do
  before(:each) do
    @cantidad_visitas = 0
    @copago = 100
    @plan = Plan.new(nombre: 'Plan Neo',
                     costo: 1000,
                     cobertura_visitas: CoberturaVisita.new(@cantidad_visitas, @copago),
                     cobertura_medicamentos: CoberturaMedicamentos.new(0),
                     edad_minima: 15, edad_maxima: 60,
                     cantidad_hijos_maxima: 3,
                     conyuge: Plan::ADMITE_CONYUGE)

    @repo = PlanRepository.new

    @plan = @repo.save(@plan)
  end

  it 'deberia guardar el plan generando un id positivo' do
    expect(@plan.id).to be_positive
  end

  it 'deberia encontrar el plan luego de haberse guardado' do
    saved_plan = @repo.find(@plan.id)

    expect(saved_plan.nombre).to eql @plan.nombre
  end

  it 'deberia devolver el plan existente cuando se solicitan todos los planes' do
    planes = @repo.all

    expect(planes.length).to be 1
    expect(planes.first.id).to eq @plan.id
  end

  it 'deberia devolver todos los planes disponibles' do # rubocop:disable RSpec/ExampleLength
    @repo.save(Plan.new(nombre: 'familiar',
                        costo: 1000,
                        cobertura_visitas: CoberturaVisita.new(@cantidad_visitas, @copago),
                        cobertura_medicamentos: CoberturaMedicamentos.new(0),
                        cantidad_hijos_maxima: 3,
                        conyuge: Plan::ADMITE_CONYUGE,
                        edad_minima: 0,
                        edad_maxima: 60))

    planes = @repo.all

    expect(planes.length).to be 2
  end

  it 'deberia devolver el costo del plan guardado' do
    saved_plan = @repo.find(@plan.id)

    expect(saved_plan.costo).to eql @plan.costo
  end

  it 'deberia poder filtrar por nombre plan' do # rubocop:disable RSpec/ExampleLength
    @repo.save(Plan.new(nombre: 'familiar',
                        costo: 1000,
                        cobertura_visitas: CoberturaVisita.new(@cantidad_visitas, 200),
                        cobertura_medicamentos: CoberturaMedicamentos.new(0),
                        cantidad_hijos_maxima: 3,
                        conyuge: Plan::ADMITE_CONYUGE,
                        edad_minima: 0,
                        edad_maxima: 60))

    plan_encontrado = @repo.find_by_name(@plan.nombre)
    expect(plan_encontrado.id).to eql @plan.id
  end

  it 'deberia poder filtrar por slug del plan' do # rubocop:disable RSpec/ExampleLength
    @repo.save(Plan.new(nombre: 'familiar',
                        costo: 1000,
                        cobertura_visitas: CoberturaVisita.new(@cantidad_visitas, 200),
                        cobertura_medicamentos: CoberturaMedicamentos.new(0),
                        cantidad_hijos_maxima: 3,
                        conyuge: Plan::ADMITE_CONYUGE,
                        edad_minima: 0,
                        edad_maxima: 60))

    plan_encontrado = @repo.find_by_name(@plan.slug)
    expect(plan_encontrado.id).to eql @plan.id
  end

  it 'deberia devolver cero planes cuando se eliminan todos' do
    @repo.delete_all

    planes = @repo.all

    expect(planes.length).to be 0
  end

  it 'deberia devolver el limite de visitas del plan guardado' do
    saved_plan = @repo.find(@plan.id)

    expect(saved_plan.cobertura_visitas.cantidad).to eql @plan.cobertura_visitas.cantidad
  end

  it 'deberia devolver la cantidad de copago del plan guardado' do
    saved_plan = @repo.find(@plan.id)

    expect(saved_plan.cobertura_visitas.copago).to eql @plan.cobertura_visitas.copago
  end

  it 'deberia devolver la cobertura a medicamentos del plan guardado' do
    saved_plan = @repo.find(@plan.id)

    expect(saved_plan.cobertura_medicamentos.porcentaje).to eql @plan.cobertura_medicamentos.porcentaje # rubocop:disable Metrics/LineLength
  end

  it 'deberia devolver la edad minima del plan guardado' do
    saved_plan = @repo.find(@plan.id)

    expect(saved_plan.edad_minima).to eql @plan.edad_minima
  end

  it 'deberia devolver la edad maxima del plan guardado' do
    saved_plan = @repo.find(@plan.id)

    expect(saved_plan.edad_maxima).to eql @plan.edad_maxima
  end

  it 'deberia devolver la cantidad de hijos maxima del plan guardado' do
    saved_plan = @repo.find(@plan.id)

    expect(saved_plan.cantidad_hijos_maxima).to eql @plan.cantidad_hijos_maxima
  end

  it 'deberia devolver conyuge del plan guardado' do
    saved_plan = @repo.find(@plan.id)

    expect(saved_plan.conyuge).to eql @plan.conyuge
  end

  it 'deberia poder arrojar error por buscar nombre plan inexistente' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
    @repo.save(Plan.new(nombre: 'familiar',
                        costo: 1000,
                        cobertura_visitas: CoberturaVisita.new(@cantidad_visitas, 200),
                        cobertura_medicamentos: CoberturaMedicamentos.new(0),
                        cantidad_hijos_maxima: 3,
                        conyuge: Plan::ADMITE_CONYUGE,
                        edad_minima: 0,
                        edad_maxima: 60))

    expect { @repo.find_by_name('noExiste') }.to raise_error(PlanNoEncontrado)
  end
end
