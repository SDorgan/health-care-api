require 'spec_helper'

describe 'DiagnosticoCovidController' do
  let(:plan) do
    Plan.new('Neo', 500, 0, CoberturaVisita.new(0, 0))
  end

  let(:fake_id_telegram) do
    'id_telegram'
  end

  before(:each) do
    plan_repo = PlanRepository.new
    @plan = plan_repo.save(plan)

    afiliado = Afiliado.new('Juan', @plan.id)
    afiliado.id_telegram = fake_id_telegram
    afiliado_repo = AfiliadoRepository.new
    @afiliado = afiliado_repo.save(afiliado)
  end

  it 'Ver si un afiliado es sospechoso cuando no lo es' do
    get "/covid/#{@afiliado.id}"
    response = JSON.parse(last_response.body)
    expect(response['sospechoso']).to be false
  end

  it 'Puedo hacer el test pasando el telegram_id en vez del id del afiliado' do
    data = { 'id_telegram': fake_id_telegram }.to_json
    post '/covid', data
    response = JSON.parse(last_response.body)
    expect(response['sospechoso']).to be true
  end

  it 'Ver si un afiliado es sospechoso cuando si lo es' do
    data = { 'id_telegram': fake_id_telegram }.to_json
    post '/covid', data

    get "/covid/#{@afiliado.id}"
    response = JSON.parse(last_response.body)
    expect(response['sospechoso']).to be true
  end
end
