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

  it 'deberia encontrar el centro luego de haberse guardado' do
    saved_centro = @repo.find(@centro.id)

    expect(saved_centro.nombre).to eql @centro.nombre
  end
end
