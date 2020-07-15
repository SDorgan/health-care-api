require 'integration_spec_helper'

describe 'PrestacionDeCentroRepository' do
  let(:centro) do
    Centro.new('Hospital Alemán')
  end

  let(:prestacion) do
    Prestacion.new('Traumatología', 1200)
  end

  before(:each) do
    centro_repo = CentroRepository.new
    @centro = centro_repo.save(centro)

    prestacion_repo = PrestacionRepository.new
    @prestacion = prestacion_repo.save(prestacion)

    @prestacion_de_hosp_aleman = PrestacionDeCentro.new(@centro, @prestacion)
    @repo = PrestacionDeCentroRepository.new

    @repo.save(@prestacion_de_hosp_aleman)
  end

  it 'debería devolver la prestacion del centro' do
    prestaciones_de_centro = @repo.find_by_centro(@centro)

    expect(prestaciones_de_centro.length).to be 1
    expect(prestaciones_de_centro.first.id).to eq @prestacion.id
  end
end
