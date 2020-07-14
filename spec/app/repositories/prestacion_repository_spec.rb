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

  xit 'deberia devolver todas las prestaciones disponibles' do
    @repo.save(Prestacione.new('Odontología', 900))

    prestaciones = @repo.all

    expect(prestaciones.length).to be 2
  end
end
