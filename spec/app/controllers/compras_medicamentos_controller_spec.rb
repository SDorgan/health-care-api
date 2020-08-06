require 'spec_helper'

describe 'ComprasMedicamentosController' do
  let(:plan) do
    plan = Plan.new(nombre: 'Neo',
                    costo: 1000,
                    cobertura_visitas: CoberturaVisita.new(0, 0),
                    cobertura_medicamentos: CoberturaMedicamentos.new(0),
                    cantidad_hijos_maxima: 1,
                    conyuge: Plan::ADMITE_CONYUGE,
                    edad_minima: 0,
                    edad_maxima: 10)

    plan
  end

  before(:each) do
    @plan = PlanRepository.new.save(plan)

    @afiliado = Afiliado.new('Juan Perez', @plan)
    @afiliado = AfiliadoRepository.new.save(@afiliado)
  end

  it 'deberia devolver la compra medica con la que se hizo POST' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
    monto_de_compra = 500
    post '/medicamentos', { 'afiliado': @afiliado.id, 'monto': monto_de_compra }.to_json, 'HTTP_API_KEY' => API_KEY
    response = JSON.parse(last_response.body)

    compra = response['compra']

    expect(compra['afiliado']).to eq @afiliado.id
    expect(compra['monto']).to eq monto_de_compra
    expect(compra['fecha_compra'].nil?).to be false
  end

  it 'deberia devolver 403 si no se manda api key' do
    monto_de_compra = 500
    post '/medicamentos', { 'afiliado': @afiliado.id, 'monto': monto_de_compra }.to_json
    expect(last_response.status).to eq 403
  end
end
