require 'integration_spec_helper'

describe 'BuscadorAfiliadoApiExterna' do
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

    @repo = AfiliadoRepository.new
    @afiliado = @repo.save(@afiliado)
  end

  it 'deberia poder buscar a un afiliado por ID' do
    buscador = BuscadorAfiliadoApiExterna.new(@repo)
    afiliado_saved = buscador.find(@afiliado.id)

    expect(afiliado_saved.nombre).to eq 'Juan'
  end
end
