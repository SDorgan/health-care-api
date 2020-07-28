require 'integration_spec_helper'

describe 'CentroRepository' do
  let(:prestacion) do
    Prestacion.new('Traumatología', 1200)
  end

  let(:latitud) do
    -34.555
  end

  let(:longitud) do
    39.501
  end

  before(:each) do
    @centro = Centro.new('Hospital Italiano', latitud, longitud)
    @repo = CentroRepository.new
    @centro = @repo.save(@centro)

    @prestacion = Prestacion.new('Traumatología', 1200)
    @prestacion_repo = PrestacionRepository.new
    @prestacion = @prestacion_repo.save(@prestacion)

    @repo.add_prestacion_to_centro(@centro, @prestacion.id)
  end

  it 'deberia guardar el centro generando un id positivo' do
    expect(@centro.id).to be_positive
  end

  it 'deberia devolver las coordenadas del centro' do
    expect(@centro.latitud).to be latitud
    expect(@centro.longitud).to be longitud
  end

  it 'deberia encontrar el centro luego de haberse guardado' do
    saved_centro = @repo.find(@centro.id)

    expect(saved_centro.nombre).to eql @centro.nombre
  end

  it 'deberia devolver el centro existente cuando se solicitan todos los centros' do
    centros = @repo.all

    expect(centros.length).to be 1
    expect(centros.first.id).to eq @centro.id
  end

  it 'deberia devolver todos los centros disponibles' do
    @repo.save(Centro.new('Hospital Aleman'))

    centros = @repo.all

    expect(centros.length).to be 2
  end

  it 'deberia devolver cero centros cuando se eliminan todos' do
    @repo.delete_all

    centros = @repo.all

    expect(centros.length).to be 0
  end

  it 'debería devolver la prestacion del centro' do
    centro = @repo.full_load(@centro.id)
    expect(centro.prestaciones.length).to be 1
    expect(centro.prestaciones.first.id).to eq @prestacion.id
  end

  it 'debería devolver error si no existe el centro' do
    fake_id = 999_999
    expect { @repo.find(fake_id) }.to raise_error
  end

  xit 'debería devolver error si no se mandan las coordenadas' do
    centro_error = Centro.new('Hospital', nil, nil)

    expect { @repo.save(centro_error) }.to raise_error
  end
end
