require 'integration_spec_helper'

describe 'VisitaMedicaRepository' do
  let(:plan) do
    plan = Plan.new('Neo', 1000)

    plan
  end

  let(:prestacion) do
    prestacion = Prestacion.new('Traumatología', 1000)

    prestacion
  end

  before(:each) do
    @plan = PlanRepository.new.save(plan)

    @prestacion = PrestacionRepository.new.save(prestacion)

    @afiliado = Afiliado.new('Juan Perez', @plan.id)
    @afiliado = AfiliadoRepository.new.save(@afiliado)
  end

  it 'deberia poder guardar la visita generando un id positivo' do
    repo = VisitaMedicaRepository.new

    visita_medica = VisitaMedica.new(@afiliado.id, @prestacion)

    visita_medica = repo.save(visita_medica)

    expect(visita_medica.id.positive?).to be true
  end

  it 'deberia poder guardar la visita generando una fecha' do
    repo = VisitaMedicaRepository.new

    visita_medica = VisitaMedica.new(@afiliado.id, @prestacion)

    visita_medica = repo.save(visita_medica)

    expect(visita_medica.created_on.nil?).to be false
  end

  it 'deberia poder obtener la visita que se guardo' do # rubocop:disable RSpec/ExampleLength
    repo = VisitaMedicaRepository.new

    visita_medica = VisitaMedica.new(@afiliado.id, @prestacion)

    visita_medica = repo.save(visita_medica)
    visita_medica_saved = repo.find(visita_medica.id)

    expect(visita_medica_saved.afiliado_id).to eq @afiliado.id
    expect(visita_medica_saved.prestacion_id).to eq @prestacion.id
  end
end
