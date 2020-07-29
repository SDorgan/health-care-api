require 'spec_helper'
require 'date'

describe 'ResumenController' do
  let(:plan) do
    plan = Plan.new(nombre: 'Neo',
                    costo: 1000,
                    cobertura_visitas: CoberturaVisita.new(0, 0),
                    cobertura_medicamentos: CoberturaMedicamentos.new(0),
                    cantidad_hijos_maxima: 1,
                    edad_minima: 0,
                    edad_maxima: 10)

    plan
  end

  let(:prestacion) do
    prestacion = Prestacion.new('Traumatología', 1000)

    prestacion
  end

  let(:centro) do
    centro = Centro.new('Hospital Suizo', 10.0, 12.0)

    centro
  end

  before(:each) do
    @plan = PlanRepository.new.save(plan)
    @prestacion = PrestacionRepository.new.save(prestacion)
    @centro = CentroRepository.new.save(centro)

    @afiliado = Afiliado.new('Juan Perez', @plan)
    @afiliado.id_telegram = '1'

    @afiliado = AfiliadoRepository.new.save(@afiliado)

    @visita_medica = VisitaMedica.new(@afiliado.id, @prestacion, @centro)
    @repo_visitas = VisitaMedicaRepository.new

    ENV['TEST_DATE'] = '02/01/2020'
    @visita_medica = @repo_visitas.save(@visita_medica)

    @compra_medicamentos = CompraMedicamentos.new(@afiliado.id, 500)

    @repo_compras = CompraMedicamentosRepository.new

    ENV['TEST_DATE'] = '01/01/2020'
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

  it 'deberia devolver los items en orden' do # rubocop:disable RSpec/ExampleLength
    get "/resumen?id=#{@afiliado.id}&from=api"

    response = JSON.parse(last_response.body)

    resumen = response['resumen']
    items = resumen['items']
    fecha_primero = Date.strptime(items[0]['fecha'], '%d/%m/%Y')
    fecha_segundo = Date.strptime(items[1]['fecha'], '%d/%m/%Y')
    expect(fecha_primero < fecha_segundo).to eq true
  end

  it 'deberia ser error si el ID no es de afiliado' do
    get '/resumen?id=9999&from=telegram'

    expect(last_response.status).to be 401
  end
end
