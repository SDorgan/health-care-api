require 'integration_spec_helper'

describe 'AfiliadoRepository' do
  before(:each) do
    @plan = Plan.new(nombre: 'Neo',
                     costo: 1000,
                     cobertura_visitas: CoberturaVisita.new(0, 0),
                     cobertura_medicamentos: CoberturaMedicamentos.new(0),
                     edad_minima: 0)
    @plan_repository = PlanRepository.new
    @plan = @plan_repository.save(@plan)
    @afiliado = Afiliado.new('Juan', @plan.id)
    @repo = AfiliadoRepository.new
  end

  it 'deberia obtener el afiliado luego guardarse' do # rubocop:disable RSpec/ExampleLength
    @afiliado.id_telegram = '1'
    @repo = AfiliadoRepository.new

    @afiliado = @repo.save(@afiliado)
    afiliado_obtenido = @repo.all
    expect(afiliado_obtenido.first.nombre).to eq @afiliado.nombre
    expect(afiliado_obtenido.first.id_telegram).to eq @afiliado.id_telegram
    expect(afiliado_obtenido.first.plan_id).to eq @afiliado.plan_id
  end

  it 'deberia poder guardar afiliado sin id telegram' do
    @repo = AfiliadoRepository.new

    @afiliado = @repo.save(@afiliado)
    afiliado_obtenido = @repo.all
    expect(afiliado_obtenido.first.nombre).to eq @afiliado.nombre
    expect(afiliado_obtenido.first.id_telegram).to eq ''
  end

  it 'afiliado nuevo en la base debería no ser covid sospechoso' do
    @repo = AfiliadoRepository.new

    @afiliado = @repo.save(@afiliado)
    afiliado_obtenido = @repo.all
    expect(afiliado_obtenido.first.covid_sospechoso).to eq false
  end

  it 'afiliado covid sospechoso' do
    @repo = AfiliadoRepository.new
    @afiliado.covid_sospechoso = true

    @afiliado = @repo.save(@afiliado)
    afiliado_obtenido = @repo.all
    expect(afiliado_obtenido.first.covid_sospechoso).to eq true
  end

  it 'deberia poder ver todos los sospechosos' do
    @repo = AfiliadoRepository.new
    @afiliado.covid_sospechoso = true

    @afiliado = @repo.save(@afiliado)
    afiliados_sospechosos = @repo.find_sospechosos
    expect(afiliados_sospechosos.length.positive?).to eq true
  end

  it 'deberia poder ver si un usuario es sospechoso' do
    @repo = AfiliadoRepository.new
    @afiliado.covid_sospechoso = true

    @afiliado = @repo.save(@afiliado)
    sospechoso = @repo.es_sospechoso(@afiliado.id)
    expect(sospechoso).to eq true
  end

  it 'deberia ser error si no existe el afiliado que se busca por telegram_id' do
    expect { @repo.find_by_telegram_id('FAKE_ID') }.to raise_error
  end

  it 'deberia ser error si no existe el afiliado que se busca por id' do
    fake_id = 999_999
    expect { @repo.find(fake_id) }.to raise_error
  end
end
