require 'spec_helper'

describe 'DiagnosticoCovidController' do
  let(:plan) do
    Plan.new(nombre: 'Neo',
             costo: 1000,
             cobertura_visitas: CoberturaVisita.new(0, 0),
             cobertura_medicamentos: CoberturaMedicamentos.new(0),
             cantidad_hijos_maxima: 1,
             conyuge: Plan::ADMITE_CONYUGE,
             edad_minima: 0,
             edad_maxima: 10)
  end

  let(:fake_id_telegram) do
    'id_telegram'
  end

  before(:each) do
    plan_repo = PlanRepository.new
    @plan = plan_repo.save(plan)

    afiliado = Afiliado.new('Juan', @plan)
    afiliado.id_telegram = fake_id_telegram
    afiliado_repo = AfiliadoRepository.new
    @afiliado = afiliado_repo.save(afiliado)
  end

  it 'Ver si un afiliado es sospechoso cuando no lo es' do
    get "/covid/#{@afiliado.id}", {}, 'HTTP_API_KEY' => API_KEY
    response = JSON.parse(last_response.body)
    expect(response['sospechoso']).to be false
  end

  it 'Puedo hacer el test pasando el telegram_id en vez del id del afiliado' do
    data = { 'id_telegram': fake_id_telegram }.to_json
    post '/covid', data, 'HTTP_API_KEY' => API_KEY
    response = JSON.parse(last_response.body)
    expect(response['sospechoso']).to be true
  end

  it 'Ver si un afiliado es sospechoso cuando si lo es' do
    data = { 'id_telegram': fake_id_telegram }.to_json
    post '/covid', data, 'HTTP_API_KEY' => API_KEY

    get "/covid/#{@afiliado.id}", {}, 'HTTP_API_KEY' => API_KEY
    response = JSON.parse(last_response.body)
    expect(response['sospechoso']).to be true
  end

  it 'deberia devolver 403 al no tener api key' do
    data = { 'id_telegram': fake_id_telegram }.to_json
    post '/covid', data
    expect(last_response.status).to be 403
  end
end
