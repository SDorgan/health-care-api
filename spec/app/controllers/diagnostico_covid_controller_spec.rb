require 'spec_helper'

describe 'DiagnosticoCovidController' do
  let(:plan) do
    Plan.new('Neo', 500)
  end

  before(:each) do
    plan_repo = PlanRepository.new
    @plan = plan_repo.save(plan)

    afiliado = Afiliado.new('Juan', @plan.id)
    afiliado_repo = AfiliadoRepository.new
    @afiliado = afiliado_repo.save(afiliado)
  end

  xit 'diagnostico negativo debería dar no sospechoso con 36 grados' do
    data = { 'temperatura': 36, 'afiliado': @afiliado.id }
    post '/covid', data
    !last_response.body.include?('Sospechoso')
  end

  xit 'diagnostico negativo debería dar sospechoso con 40 grados' do
    data = { 'temperatura': 40, 'afiliado': @afiliado.id }
    post '/covid', data
    last_response.body.include?('Sospechoso')
  end

  xit 'diagnostico negativo debería dar sospechoso con 37 grados' do
    data = { 'temperatura': 37, 'afiliado': @afiliado.id }
    post '/covid', data
    last_response.body.include?('Sospechoso')
  end
end
