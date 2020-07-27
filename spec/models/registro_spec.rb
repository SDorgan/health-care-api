require 'spec_helper'
require_relative '../../app/errors/plan_inexistente_error'
require_relative '../../app/errors/edad_maxima_supera_limite_error'
require_relative '../../app/errors/edad_minima_no_alcanza_limite_error'
require_relative '../../app/errors/no_se_admite_conyuge_error'
require_relative '../../app/errors/se_requiere_conyuge_error'
require_relative '../../app/errors/no_se_admite_hijos_error'

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
                     edad_minima: 10, edad_maxima: 40,
                     cantidad_hijos_maxima: 0, conyuge: Plan.no_admite_conyuge)
    @plan_require_conyuge = Plan.new(nombre: 'PlanFamiliar',
                                     costo: 1000,
                                     cobertura_visitas: CoberturaVisita.new(0, 0),
                                     cobertura_medicamentos: CoberturaMedicamentos.new(0),
                                     edad_minima: 10, edad_maxima: 40,
                                     cantidad_hijos_maxima: 0, conyuge: Plan.requiere_conyuge)
    plan_repository.save(@plan_require_conyuge)
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

  it 'deberia poder devolver error edad no alcanza limiite cuando es menor' do
    expect do
      @registro.registrar_afiliado(nombre_afiliado: 'Juan', nombre_plan: 'Neo',
                                   id_telegram: 'fake_id', edad: 8,
                                   cantidad_hijos: 0, conyuge: false)
    end.to raise_error(EdadMinimaNoAlcanzaLimiteError)
  end

  it 'deberia poder devolver error por tener conyuge cuando el plan no lo admite' do
    expect do
      @registro.registrar_afiliado(nombre_afiliado: 'Juan', nombre_plan: 'Neo',
                                   id_telegram: 'fake_id', edad: 18,
                                   cantidad_hijos: 0, conyuge: true)
    end.to raise_error(NoSeAdmiteConyugeError)
  end

  it 'deberia poder devolver error por no tener conyuge cuando el plan lo requiere' do
    expect do
      @registro.registrar_afiliado(nombre_afiliado: 'Juan', nombre_plan: 'PlanFamiliar',
                                   id_telegram: 'fake_id', edad: 18,
                                   cantidad_hijos: 0, conyuge: false)
    end.to raise_error(SeRequiereConyugeError)
  end

  it 'deberia poder devolver error por tener hijos cuando el plan no admite' do
    expect do
      @registro.registrar_afiliado(nombre_afiliado: 'Juan', nombre_plan: 'Neo',
                                   id_telegram: 'fake_id', edad: 18,
                                   cantidad_hijos: 1, conyuge: false)
    end.to raise_error(NoSeAdmiteHijosError)
  end
end
