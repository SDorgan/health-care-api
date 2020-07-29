require 'integration_spec_helper'

describe 'BuscadorAfiliadoTelegram' do
  before(:each) do
    @plan = Plan.new(nombre: 'Neo',
                     costo: 1000,
                     cobertura_visitas: CoberturaVisita.new(0, 0),
                     cobertura_medicamentos: CoberturaMedicamentos.new(0),
                     edad_minima: 0,
                     edad_maxima: 10)

    @plan_repository = PlanRepository.new
    @plan = @plan_repository.save(@plan)

    @afiliado = Afiliado.new('Juan', @plan)
    @afiliado.id_telegram = '1'

    @repo = AfiliadoRepository.new
    @afiliado = @repo.save(@afiliado)
  end

  it 'deberia poder buscar a un afiliado por Telegram ID' do
    buscador = BuscadorAfiliadoTelegram.new(@repo)
    afiliado_saved = buscador.find('1')

    expect(afiliado_saved.nombre).to eq 'Juan'
  end
end
