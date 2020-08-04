require 'spec_helper'

describe 'Centro' do
  it 'deberia poder devolver los atributos con los que fue creado' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength, RSpec/MultipleExpectations
    nombre = 'Hospital Alemán'
    latitud = -35.45
    longitud = -36.7
    centro = Centro.new(nombre, latitud, longitud)

    slug_name = 'hospital_aleman'

    expect(centro.nombre).to eql nombre
    expect(centro.latitud).to eql latitud
    expect(centro.longitud).to eql longitud
    expect(centro.slug).to eql slug_name
  end
end
