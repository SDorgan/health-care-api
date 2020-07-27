require 'spec_helper'

describe 'AfiliadosController' do
  let(:plan) do
    plan = Plan.new(nombre: 'PlanJuventud',
                    costo: 100,
                    cobertura_visitas: CoberturaVisita.new(0, 0),
                    cobertura_medicamentos: CoberturaMedicamentos.new(0),
                    edad_minima: 1, edad_maxima: 40, cantidad_hijos_maxima: 0,
                    conyuge: Plan.no_admite_conyuge)

    plan
  end

  let(:plan_requiere_conyuge) do
    plan_requiere_conyuge = Plan.new(nombre: 'PlanFamiliar',
                                     costo: 100,
                                     cobertura_visitas: CoberturaVisita.new(0, 0),
                                     cobertura_medicamentos: CoberturaMedicamentos.new(0),
                                     edad_minima: 1, edad_maxima: 40, cantidad_hijos_maxima: 0,
                                     conyuge: Plan.requiere_conyuge)

    plan_requiere_conyuge
  end

  let(:plan_requiere_hijos) do
    plan_requiere_hijos = Plan.new(nombre: 'PlanFamiliarConHijos',
                                   costo: 100,
                                   cobertura_visitas: CoberturaVisita.new(0, 0),
                                   cobertura_medicamentos: CoberturaMedicamentos.new(0),
                                   edad_minima: 1, edad_maxima: 40, cantidad_hijos_maxima: 2,
                                   conyuge: Plan.requiere_conyuge)

    plan_requiere_hijos
  end

  before(:each) do
    PlanRepository.new.save(plan_requiere_conyuge)
    PlanRepository.new.save(plan_requiere_hijos)
    @plan = PlanRepository.new.save(plan)
    @afiliado = Afiliado.new('Juan', @plan.id)
    @afiliado = AfiliadoRepository.new.save(@afiliado)
  end

  it 'deberia devoler los afiliados' do
    get '/afiliados'
    last_response.body.include?('afiliados')
  end

  it 'deberia devolver un id al crearse con un plan' do
    post '/afiliados', { 'nombre': 'Juan Perez', 'nombre_plan': 'PlanJuventud', 'cantidad_hijos': 0, 'edad': 18, 'conyuge': false }.to_json
    last_response.body.include?('id')
  end

  it 'deberia devolver un id al crearse con un plan y id telegram' do
    post '/afiliados', { 'nombre': 'Juan Perez', 'nombre_plan': 'PlanJuventud', 'id_telegram': '10', 'cantidad_hijos': 0, 'edad': 18, 'conyuge': false }.to_json
    last_response.body.include?('id')
  end

  it 'deberia devolver error por superar limite edad' do
    post '/afiliados', { 'nombre': 'Juan Perez', 'nombre_plan': 'PlanJuventud', 'id_telegram': '10', 'cantidad_hijos': 0, 'edad': 60, 'conyuge': false }.to_json
    expect(last_response.status).to be 400
  end

  it 'deberia devolver error por no alcanzar minimo de edad' do
    post '/afiliados', { 'nombre': 'Juan Perez', 'nombre_plan': 'PlanJuventud', 'id_telegram': '10', 'cantidad_hijos': 0, 'edad': 0, 'conyuge': false }.to_json
    expect(last_response.status).to be 400
  end

  it 'deberia devolver error por no admitir conyuge' do
    post '/afiliados', { 'nombre': 'Juan Perez', 'nombre_plan': 'PlanJuventud', 'id_telegram': '10', 'cantidad_hijos': 0, 'edad': 18, 'conyuge': true }.to_json
    expect(last_response.status).to be 400
  end

  it 'deberia devolver error por no tener conyuge cuando es requerido' do
    post '/afiliados', { 'nombre': 'Juan Perez', 'nombre_plan': 'PlanFamiliar', 'id_telegram': '10', 'cantidad_hijos': 0, 'edad': 18, 'conyuge': false }.to_json
    expect(last_response.status).to be 400
  end

  it 'deberia devolver error por tener hijos cuando el plan no admite hijos' do
    post '/afiliados', { 'nombre': 'Juan Perez', 'nombre_plan': 'PlanJuventud', 'id_telegram': '10', 'cantidad_hijos': 1, 'edad': 18, 'conyuge': false }.to_json
    expect(last_response.status).to be 400
  end

  it 'deberia devolver error por no tener hijos cuando el plan lo requiere' do
    post '/afiliados', { 'nombre': 'Juan Perez', 'nombre_plan': 'PlanFamiliarConHijos', 'id_telegram': '10', 'cantidad_hijos': 0, 'edad': 18, 'conyuge': true }.to_json
    expect(last_response.status).to be 400
  end
end
