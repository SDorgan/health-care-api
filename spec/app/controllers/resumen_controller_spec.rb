require 'spec_helper'

describe 'ResumenController' do
  let(:plan) do
    plan = Plan.new('Neo', 1000, 0, 0, 0)

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

    @repo = VisitaMedicaRepository.new
    @visita_medica = @repo.save(@visita_medica)
  end

  it 'deberia devolver el resumen de un afiliado por Telegram' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
    get "/resumen?id=#{@afiliado.id_telegram}&from=telegram"

    response = JSON.parse(last_response.body)

    resumen = response['resumen']

    expect(resumen['afiliado']).to eq 'Juan Perez'
    expect(resumen['adicional']).to eq 1000
    expect(resumen['total']).to eq 2000
  end

  it 'debería devolver el resumen de un afiliado por ID' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
    get "/resumen?id=#{@afiliado.id}&from=api"

    response = JSON.parse(last_response.body)

    resumen = response['resumen']

    expect(resumen['afiliado']).to eq 'Juan Perez'
    expect(resumen['adicional']).to eq 1000
    expect(resumen['total']).to eq 2000
  end
end
