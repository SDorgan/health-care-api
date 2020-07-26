require 'spec_helper'

describe 'ResumenController' do
  let(:plan) do
    plan = Plan.new('Neo', 1000, CoberturaMedicamentos.new(0), CoberturaVisita.new(0, 0))

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
    @afiliado.id_telegram = '1'

    @afiliado = AfiliadoRepository.new.save(@afiliado)

    @visita_medica = VisitaMedica.new(@afiliado.id, @prestacion)

    @repo_visitas = VisitaMedicaRepository.new
    @visita_medica = @repo_visitas.save(@visita_medica)

    @compra_medicamentos = CompraMedicamentos.new(@afiliado.id, 500)

    @repo_compras = CompraMedicamentosRepository.new
    @compra_medicamentos = @repo_compras.save(@compra_medicamentos)
  end

  it 'deberia devolver el resumen de un afiliado por Telegram' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
    get "/resumen?id=#{@afiliado.id_telegram}&from=telegram"

    response = JSON.parse(last_response.body)

    resumen = response['resumen']

    expect(resumen['afiliado']).to eq 'Juan Perez'
    expect(resumen['adicional']).to eq 1500
    expect(resumen['total']).to eq 2500
  end

  it 'debería devolver el resumen de un afiliado por ID' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
    get "/resumen?id=#{@afiliado.id}&from=api"

    response = JSON.parse(last_response.body)

    resumen = response['resumen']

    expect(resumen['afiliado']).to eq 'Juan Perez'
    expect(resumen['adicional']).to eq 1500
    expect(resumen['total']).to eq 2500
  end

  it 'deberia devolver la lista de items del resumen' do
    get "/resumen?id=#{@afiliado.id}&from=api"

    response = JSON.parse(last_response.body)

    resumen = response['resumen']
    expect(resumen['items'].length).to eq 2
  end

  it 'deberia ser error si el ID no es de afiliado' do
    get '/resumen?id=9999&from=telegram'

    expect(last_response.status).to be 401
  end
end
