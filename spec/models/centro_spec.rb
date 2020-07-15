require 'spec_helper'

describe 'Centro' do
  it 'deberia poder devolver el nombre con el que fue creado' do
    nombre = 'Hospital Italiano'
    centro = Centro.new(nombre)

    expect(centro.nombre).to eql nombre
  end
end
