require 'integration_spec_helper'

describe 'PrestacionRepository' do
  before(:each) do
    @prestacion = Prestacion.new('Traumatología', 1200)
    @repo = PrestacionRepository.new

    @prestacion = @repo.save(@prestacion)
  end

  it 'deberia guardar la prestación generando un id positivo' do
    expect(@prestacion.id).to be_positive
  end

  it 'deberia encontrar la prestación luego de haberse guardado' do
    prest_guardada = @repo.find(@prestacion.id)

    expect(prest_guardada.nombre).to eql @prestacion.nombre
  end

  it 'deberia devolver la prestación existente cuando se solicitan todas las prestaciones' do
    prestaciones = @repo.all

    expect(prestaciones.length).to be 1
    expect(prestaciones.first.id).to eq @prestacion.id
  end

  it 'deberia devolver todas las prestaciones disponibles' do
    @repo.save(Prestacion.new('Odontología', 900))

    prestaciones = @repo.all

    expect(prestaciones.length).to be 2
  end

  it 'deberia devolver cero prestaciones cuando se eliminan todas' do
    @repo.delete_all

    prestaciones = @repo.all

    expect(prestaciones.length).to be 0
  end

  it 'deberia lanzar error si no existe la prestacion que se busca por id' do
    fake_id = 999_999
    expect { @repo.find(fake_id) }.to raise_error
  end

  it 'deberia lanzar error si no existe la prestacion que se busca por nombre' do
    fake_name = 'no_existe'
    expect { @repo.find_by_name(fake_name) }.to raise_error
  end

  it 'deberia poder buscar por slug' do
    prest_guardada = @repo.find_by_name(@prestacion.slug)

    expect(prest_guardada.nombre).to eql @prestacion.nombre
  end
end
