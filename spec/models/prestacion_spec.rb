require 'spec_helper'

describe 'Prestacion' do
  it 'deberia poder devolver los datos con los que fue creado' do
    nombre = 'Traumatología'
    costo = 1200
    prestacion = Prestacion.new(nombre, costo)

    expect(prestacion.nombre).to eql nombre
    expect(prestacion.costo).to eql costo
  end
end
