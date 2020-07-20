require 'integration_spec_helper'

describe 'CompraMedicamentosRepository' do
  let(:plan) do
    plan = Plan.new('Neo', 1000, 0, 0)

    plan
  end

  before(:each) do
    @plan = PlanRepository.new.save(plan)

    @afiliado = Afiliado.new('Juan Perez', @plan.id)
    @afiliado = AfiliadoRepository.new.save(@afiliado)

    @monto_de_compra = 500
    @compra_medicamentos = CompraMedicamentos.new(@afiliado.id, @monto_de_compra)

    @repo = CompraMedicamentosRepository.new
    @compra_medicamentos = @repo.save(@compra_medicamentos)
  end

  it 'deberia poder guardar la compra generando un id positivo' do
    expect(@compra_medicamentos.id.positive?).to be true
  end

  it 'deberia poder guardar la compra generando una fecha' do
    expect(@compra_medicamentos.created_on.nil?).to be false
  end

  it 'deberia poder obtener la compra que se guardo' do
    compra_medicamentos_guardada = @repo.find(@compra_medicamentos.id)

    expect(compra_medicamentos_guardada.afiliado_id).to eq @afiliado.id
    expect(compra_medicamentos_guardada.monto).to eq @monto_de_compra
  end

  it 'deberia poder obtener las compras correspondientes a un afiliado' do
    otra_compra = CompraMedicamentos.new(@afiliado.id, @monto_de_compra)
    @repo.save(otra_compra)

    compras = @repo.find_by_afiliado(@afiliado.id)

    expect(compras.length).to eq 2
  end
end
