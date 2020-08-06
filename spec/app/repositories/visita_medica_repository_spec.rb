require 'integration_spec_helper'

describe 'VisitaMedicaRepository' do
  let(:plan) do
    plan = Plan.new(nombre: 'Neo',
                    costo: 1000,
                    cobertura_visitas: CoberturaVisita.new(0, 0),
                    cobertura_medicamentos: CoberturaMedicamentos.new(0),
                    cantidad_hijos_maxima: 1,
                    conyuge: Plan::ADMITE_CONYUGE,
                    edad_minima: 0,
                    edad_maxima: 10)

    plan
  end

  let(:prestacion) do
    prestacion = Prestacion.new('Traumatología', 1000)

    prestacion
  end

  let(:centro) do
    centro = Centro.new('Hospital', 10.0, 12.0)

    centro
  end

  before(:each) do
    @plan = PlanRepository.new.save(plan)

    @prestacion = PrestacionRepository.new.save(prestacion)
    @centro = CentroRepository.new.save(centro)

    @afiliado = Afiliado.new('Juan Perez', @plan)
    @afiliado = AfiliadoRepository.new.save(@afiliado)

    @visita_medica = VisitaMedica.new(@afiliado.id, @prestacion, @centro)

    @repo = VisitaMedicaRepository.new
    @visita_medica = @repo.save(@visita_medica)
  end

  it 'deberia poder guardar la visita generando un id positivo' do
    expect(@visita_medica.id.positive?).to be true
  end

  it 'deberia poder guardar la visita generando una fecha' do
    expect(@visita_medica.fecha_visita.nil?).to be false
  end

  it 'deberia poder obtener la visita que se guardo' do
    visita_medica_saved = @repo.find(@visita_medica.id)

    expect(visita_medica_saved.afiliado_id).to eq @afiliado.id
    expect(visita_medica_saved.prestacion.id).to eq @prestacion.id
    expect(visita_medica_saved.centro.id).to eq @centro.id
  end

  it 'deberia poder obtener las visitas correspondientes a un afiliado' do
    otra_visita = VisitaMedica.new(@afiliado.id, @prestacion, @centro)
    @repo.save(otra_visita)

    visitas = @repo.find_by_afiliado(@afiliado.id)

    expect(visitas.length).to eq 2
  end
end
