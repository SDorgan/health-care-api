require 'spec_helper'

describe 'Prestacion' do
  it 'deberia poder devolver los datos con los que fue creado' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
    nombre = 'Traumatología'
    slug = 'traumatologia'
    costo = 1200
    prestacion = Prestacion.new(nombre, costo)

    expect(prestacion.nombre).to eql nombre
    expect(prestacion.slug).to eql slug
    expect(prestacion.costo).to eql costo
  end
end
