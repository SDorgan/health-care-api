require 'spec_helper'

describe 'Centro' do
  xit 'deberia poder devolver el nombre con el que fue creado' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
    nombre = 'Hospital Italiano'
    latitud = -35.45
    longitud = -36.7
    centro = Centro.new(nombre, latitud, longitud)

    expect(centro.nombre).to eql nombre
    expect(centro.latitud).to eql latitud
    expect(centro.longitud).to eql longitud
  end
end
