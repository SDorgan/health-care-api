require 'integration_spec_helper'

describe 'PlanRepository' do
  before(:each) do
    @cantidad_visitas = 0
    @copago = 100
    @plan = Plan.new('neo', 1000, CoberturaMedicamentos.new(0), CoberturaVisita.new(@cantidad_visitas, @copago)) # rubocop:disable Metrics/LineLength
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

  it 'deberia devolver todos los planes disponibles' do
    @repo.save(Plan.new('familiar', 1000, CoberturaMedicamentos.new(0), CoberturaVisita.new(@cantidad_visitas, @copago))) # rubocop:disable Metrics/LineLength

    planes = @repo.all

    expect(planes.length).to be 2
  end

  it 'deberia devolver el costo del plan guardado' do
    saved_plan = @repo.find(@plan.id)

    expect(saved_plan.costo).to eql @plan.costo
  end

  it 'deberia poder filtrar por nombre plan' do
    @repo.save(Plan.new('familiar', 1000, CoberturaMedicamentos.new(0), CoberturaVisita.new(@cantidad_visitas, 200))) # rubocop:disable Metrics/LineLength
    plan_encontrado = @repo.find_by_name(@plan.nombre)
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
end
