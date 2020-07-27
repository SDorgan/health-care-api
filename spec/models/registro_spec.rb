require 'spec_helper'

describe 'Registro' do
  let(:afiliado_repository) do
    AfiliadoRepository.new
  end

  let(:plan_repository) do
    PlanRepository.new
  end

  before(:each) do
    @plan = Plan.new(nombre: 'Neo',
                     costo: 1000,
                     cobertura_visitas: CoberturaVisita.new(0, 0),
                     cobertura_medicamentos: CoberturaMedicamentos.new(0),
                     edad_minima: 10, edad_maxima: 40, conyuge: Plan.admite_conyuge)
    @plan = plan_repository.save(@plan)
    @registro = Registro.new(afiliado_repository, plan_repository)
  end

  it 'deberia poder registrar el afiliado' do
    afiliado = @registro.registrar_afiliado('Juan', 'Neo', 'fake_id', 20, false)
    expect(afiliado.nombre).to eql 'Juan'
  end
end
