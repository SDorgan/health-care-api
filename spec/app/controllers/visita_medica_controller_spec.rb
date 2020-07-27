require 'spec_helper'

describe 'VisitaMedicaController' do
  let(:plan) do
    plan = Plan.new(nombre: 'Neo',
                    costo: 1000,
                    cobertura_visitas: CoberturaVisita.new(0, 0),
                    cobertura_medicamentos: CoberturaMedicamentos.new(0),
                    edad_minima: 0)

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
  end

  it 'deberia devolver la visita medica con la que se hizo POST' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
    post '/visitas', { 'afiliado': @afiliado.id, 'prestacion': @prestacion.id }.to_json
    response = JSON.parse(last_response.body)

    visita = response['visita']

    expect(visita['afiliado']).to eq @afiliado.id
    expect(visita['prestacion']).to eq @prestacion.nombre
    expect(visita['created_on'].nil?).to be false
  end

  it 'deberia devolver error si no se encuentra al afiliado' do
    post '/visitas', { 'afiliado': @afiliado.id + 1, 'prestacion': @prestacion.id }.to_json

    expect(last_response.status).to be 401
  end
end
