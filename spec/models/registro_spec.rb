require 'spec_helper'
require_relative '../../app/errors/plan_inexistente_error'
require_relative '../../app/errors/edad_maxima_supera_limite_error'

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
    afiliado = @registro.registrar_afiliado(nombre_afiliado: 'Juan', nombre_plan: 'Neo',
                                            id_telegram: 'fake_id', edad: 20,
                                            cantidad_hijos: 0, conyuge: false)
    expect(afiliado.nombre).to eql 'Juan'
  end

  it 'deberia poder devolver error plan no existente cuando es inexistente' do
    expect do
      @registro.registrar_afiliado(nombre_afiliado: 'Juan', nombre_plan: 'noExiste',
                                   id_telegram: 'fake_id', edad: 20,
                                   cantidad_hijos: 0, conyuge: false)
    end.to raise_error(PlanInexistenteError)
  end

  it 'deberia poder devolver error limite edad cuando supera el limite' do
    expect do
      @registro.registrar_afiliado(nombre_afiliado: 'Juan', nombre_plan: 'Neo',
                                   id_telegram: 'fake_id', edad: 60,
                                   cantidad_hijos: 0, conyuge: false)
    end.to raise_error(EdadMaximaSuperaLimiteError)
  end
end
