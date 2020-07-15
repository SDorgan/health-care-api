require 'spec_helper'

describe 'PrestacionDePlanController' do
  let(:plan) do
    Plan.new('Neo')
  end

  let(:prestacion) do
    Prestacion.new('Traumatología', 1200)
  end

  before(:each) do
    plan_repo = PlanRepository.new
    @plan = plan_repo.save(plan)

    prestacion_repo = PrestacionRepository.new
    @prestacion = prestacion_repo.save(prestacion)

    prestacion_de_neo = PrestacionDePlan.new(@plan, @prestacion)
    @repo = PrestacionDePlanRepository.new

    @prestacion_de_neo = @repo.save(prestacion_de_neo)
  end

  it 'deberia devoler las prestaciones del plan' do
    get "/planes/#{@plan.id}/prestaciones"
    last_response.body.include?('prestaciones')
  end

  xit 'deberia devolver ok al hacer el POST' do
    post "/planes/#{@plan.id}/prestaciones", { 'prestacion': 'Traumatología' }.to_json
    last_response.body.include?('ok')
  end
end
