require 'spec_helper'

describe 'ComprasMedicamentosController' do
  let(:plan) do
    plan = Plan.new(nombre: 'Neo',
                    costo: 1000,
                    cobertura_visitas: CoberturaVisita.new(0, 0),
                    cobertura_medicamentos: CoberturaMedicamentos.new(0),
                    edad_minima: 0)

    plan
  end

  before(:each) do
    @plan = PlanRepository.new.save(plan)

    @afiliado = Afiliado.new('Juan Perez', @plan.id)
    @afiliado = AfiliadoRepository.new.save(@afiliado)
  end

  it 'deberia devolver la compra medica con la que se hizo POST' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
    monto_de_compra = 500
    post '/medicamentos', { 'afiliado': @afiliado.id, 'monto': monto_de_compra }.to_json
    response = JSON.parse(last_response.body)

    compra = response['compra']

    expect(compra['afiliado']).to eq @afiliado.id
    expect(compra['monto']).to eq monto_de_compra
    expect(compra['created_on'].nil?).to be false
  end
end
