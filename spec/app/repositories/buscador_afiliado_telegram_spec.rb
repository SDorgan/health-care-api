require 'integration_spec_helper'

describe 'BuscadorAfiliadoTelegram' do
  before(:each) do
    @plan = Plan.new('neo', 100, 0, CoberturaVisita.new(0, 0))

    @plan_repository = PlanRepository.new
    @plan = @plan_repository.save(@plan)

    @afiliado = Afiliado.new('Juan', @plan.id)
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
