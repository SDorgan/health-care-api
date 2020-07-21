require 'integration_spec_helper'

describe 'VisitaMedicaRepository' do
  let(:plan) do
    plan = Plan.new('Neo', 1000, 0, 0, 0)

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

    @visita_medica = VisitaMedica.new(@afiliado.id, @prestacion)

    @repo = VisitaMedicaRepository.new
    @visita_medica = @repo.save(@visita_medica)
  end

  it 'deberia poder guardar la visita generando un id positivo' do
    expect(@visita_medica.id.positive?).to be true
  end

  it 'deberia poder guardar la visita generando una fecha' do
    expect(@visita_medica.created_on.nil?).to be false
  end

  it 'deberia poder obtener la visita que se guardo' do
    visita_medica_saved = @repo.find(@visita_medica.id)

    expect(visita_medica_saved.afiliado_id).to eq @afiliado.id
    expect(visita_medica_saved.prestacion.id).to eq @prestacion.id
  end

  it 'deberia poder obtener las visitas correspondientes a un afiliado' do
    otra_visita = VisitaMedica.new(@afiliado.id, @prestacion)
    @repo.save(otra_visita)

    visitas = @repo.find_by_afiliado(@afiliado.id)

    expect(visitas.length).to eq 2
  end
end
