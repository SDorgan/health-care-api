require 'integration_spec_helper'

describe 'CompraMedicamentosRepository' do
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

    @monto_de_compra = 500
    @compra_medicamentos = CompraMedicamentos.new(@afiliado.id, @monto_de_compra)

    @repo = CompraMedicamentosRepository.new
  end

  it 'deberia poder guardar la compra generando un id positivo' do
    @compra_medicamentos = @repo.save(@compra_medicamentos)
    expect(@compra_medicamentos.id.positive?).to be true
  end

  it 'deberia poder guardar la compra generando una fecha' do
    @compra_medicamentos = @repo.save(@compra_medicamentos)
    expect(@compra_medicamentos.fecha_compra.nil?).to be false
  end

  it 'deberia poder obtener la compra que se guardo' do
    @compra_medicamentos = @repo.save(@compra_medicamentos)
    compra_medicamentos_guardada = @repo.find(@compra_medicamentos.id)

    expect(compra_medicamentos_guardada.afiliado_id).to eq @afiliado.id
    expect(compra_medicamentos_guardada.monto).to eq @monto_de_compra
  end

  it 'deberia poder obtener las compras correspondientes a un afiliado' do
    @compra_medicamentos = @repo.save(@compra_medicamentos)

    otra_compra = CompraMedicamentos.new(@afiliado.id, @monto_de_compra)
    @repo.save(otra_compra)

    compras = @repo.find_by_afiliado(id: @afiliado.id)

    expect(compras.length).to eq 2
  end

  it 'deberia poder obtener las compras correspondientes a un afiliado del mes' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
    # visita en: enero
    ENV['TEST_DATE'] = '02/01/2020'
    otra_compra = CompraMedicamentos.new(@afiliado.id, @monto_de_compra)
    @repo.save(otra_compra)

    # visita en: marzo
    ENV['TEST_DATE'] = '02/03/2020'
    otra_compra = CompraMedicamentos.new(@afiliado.id, @monto_de_compra)
    @repo.save(otra_compra)

    # visita en: marzo
    ENV['TEST_DATE'] = '12/03/2020'
    otra_compra = CompraMedicamentos.new(@afiliado.id, @monto_de_compra)
    @repo.save(otra_compra)

    # consulta en: marzo
    ENV['TEST_DATE'] = '22/03/2020'
    fecha = {
      inicio: DateManager.inicio_mes,
      fin: DateManager.fin_mes
    }

    compras = @repo.find_by_afiliado(id: @afiliado.id, fecha: fecha)

    expect(compras.length).to eq 2
  end
end
