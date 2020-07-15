require 'spec_helper'

describe 'App' do
  before(:each) do
    data = { 'nombre' => 'PlanJuventud', 'precio' => 100 }.to_json
    post '/planes', data
  end

  it 'deberia guardarse el plan ingresado' do
    @repo = PlanRepository.new
    planes = @repo.all
    expect(planes.length).to be 1
  end
end
