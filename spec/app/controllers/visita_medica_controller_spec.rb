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

  let(:centro) do
    centro = Centro.new('Hospital Alemán')

    centro
  end

  before(:each) do
    @plan = PlanRepository.new.save(plan)

    @prestacion = PrestacionRepository.new.save(prestacion)

    @centro = CentroRepository.new.save(centro)

    @afiliado = Afiliado.new('Juan Perez', @plan.id)
    @afiliado = AfiliadoRepository.new.save(@afiliado)
  end

  it 'deberia devolver la visita medica con la que se hizo POST' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
    post '/visitas', { 'afiliado': @afiliado.id, 'prestacion': @prestacion.id, 'centro': @centro.id }.to_json
    response = JSON.parse(last_response.body)

    visita = response['visita']

    expect(visita['afiliado']).to eq @afiliado.id
    expect(visita['prestacion']).to eq @prestacion.nombre
    expect(visita['created_on'].nil?).to be false
  end

  it 'deberia devolver error si no se encuentra al afiliado' do
    post '/visitas', { 'afiliado': @afiliado.id + 1, 'prestacion': @prestacion.id, 'centro': @centro.id }.to_json

    expect(last_response.status).to be 401
    expect(last_response.body).to eq 'El ID no pertenece a un afiliado'
  end

  it 'deberia devolver error si no se encuentra la prestacion' do
    post '/visitas', { 'afiliado': @afiliado.id, 'prestacion': @prestacion.id + 1, 'centro': @centro.id }.to_json

    expect(last_response.status).to be 404
    expect(last_response.body).to eq 'La prestación pedida no existe'
  end

  it 'deberia devolver error si no se encuentra el centro' do
    post '/visitas', { 'afiliado': @afiliado.id, 'prestacion': @prestacion.id, 'centro': @centro.id + 1 }.to_json

    expect(last_response.status).to be 404
    expect(last_response.body).to eq 'El centro pedido no existe'
  end

  xit 'deberia devolver error si la prestación no se da en el centro' do
    otra_prestacion = Prestacion.new('Odontología', 600)
    otra_prestacion = PrestacionRepository.new.save(otra_prestacion)

    post '/visitas', { 'afiliado': @afiliado.id, 'prestacion': otra_prestacion, 'centro': @centro.id }.to_json

    expect(last_response.status).to be 404
    expect(last_response.body).to eq 'La prestación pedida no se ofrece en el centro'
  end
end
