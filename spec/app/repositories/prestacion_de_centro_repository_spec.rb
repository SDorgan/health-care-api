require 'integration_spec_helper'

describe 'PrestacionDeCentroRepository' do
  let(:centro) do
    Centro.new('Hospital Alemán')
  end

  let(:otro_centro) do
    Centro.new('Hospital Italiano')
  end

  let(:prestacion) do
    Prestacion.new('Traumatología', 1200)
  end

  before(:each) do
    centro_repo = CentroRepository.new
    @centro = centro_repo.save(centro)
    @otro_centro = centro_repo.save(otro_centro)

    prestacion_repo = PrestacionRepository.new
    @prestacion = prestacion_repo.save(prestacion)

    @prestacion_de_hosp_aleman = PrestacionDeCentro.new(@centro, @prestacion)
    @prestacion_de_hosp_italiano = PrestacionDeCentro.new(@otro_centro, @prestacion)

    @repo = PrestacionDeCentroRepository.new

    @repo.save(@prestacion_de_hosp_aleman)
    @repo.save(@prestacion_de_hosp_italiano)
  end

  it 'debería devolver la prestacion del centro' do
    prestaciones_de_centro = @repo.find_by_centro(@centro)

    expect(prestaciones_de_centro.length).to be 1
    expect(prestaciones_de_centro.first.id).to eq @prestacion.id
  end

  it 'al crear una prestacion para otro centro, debería devolver solo las prestacion del centro' do
    prestaciones_de_centro = @repo.find_by_centro(@centro)

    expect(prestaciones_de_centro.length).to be 1
    expect(@repo.all.length).to eq 2
  end
end
