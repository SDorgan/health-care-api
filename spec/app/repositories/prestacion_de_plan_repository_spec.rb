require 'integration_spec_helper'

describe 'PrestacionDePlanRepository' do
  let(:plan) do
    Plan.new('Neo', 500)
  end

  let(:otro_plan) do
    Plan.new('Jubilados', 700)
  end

  let(:prestacion) do
    Prestacion.new('Traumatología', 1200)
  end

  let(:otra_prestacion) do
    Prestacion.new('Odontología', 1100)
  end

  before(:each) do
    plan_repo = PlanRepository.new
    @plan = plan_repo.save(plan)
    @otro_plan = plan_repo.save(otro_plan)

    prestacion_repo = PrestacionRepository.new
    @prestacion = prestacion_repo.save(prestacion)
    @otra_prestacion = prestacion_repo.save(otra_prestacion)

    prestacion_de_neo = PrestacionDePlan.new(@plan, @prestacion)
    prestacion_de_jubilados = PrestacionDePlan.new(@otro_plan, @otra_prestacion)
    @repo = PrestacionDePlanRepository.new

    @prestacion_de_neo = @repo.save(prestacion_de_neo)
    @prestacion_de_jubilados = @repo.save(prestacion_de_jubilados)
  end

  it 'debería devolver la prestacion del plan' do
    prestaciones_de_plan = @repo.find_by_plan(@plan)

    expect(prestaciones_de_plan.length).to be 1
    expect(prestaciones_de_plan.first.id).to eq @prestacion.id
  end

  it 'al crear una prestacion para otro plan, debería devolver solo las prestacion del plan' do
    prestaciones_de_plan = @repo.find_by_plan(@plan)

    expect(prestaciones_de_plan.length).to be 1
    expect(@repo.all.length).to eq 2
  end

  it 'deberia devolver todas las prestaciones disponibles del plan' do
    otra_prestacion_de_neo = PrestacionDePlan.new(@plan, @otra_prestacion)
    @repo.save(otra_prestacion_de_neo)

    prestaciones_de_plan = @repo.find_by_plan(@plan)

    expect(prestaciones_de_plan.length).to be 2
  end
end
