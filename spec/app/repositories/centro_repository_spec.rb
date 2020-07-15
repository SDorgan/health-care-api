require 'integration_spec_helper'

describe 'CentroRepository' do
  before(:each) do
    @centro = Centro.new('Hospital Italiano')
    @repo = CentroRepository.new

    @centro = @repo.save(@centro)
  end

  it 'deberia guardar el centro generando un id positivo' do
    expect(@centro.id).to be_positive
  end
end
