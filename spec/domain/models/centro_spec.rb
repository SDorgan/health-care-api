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

  it 'si se le asigna una dirección, debería tenerla' do # rubocop:disable RSpec/ExampleLength
    nombre = 'Hospital Alemán'
    latitud = -35.45
    longitud = -36.7
    direccion = '432 Maipú'
    distancia = 4
    centro = Centro.new(nombre, latitud, longitud)
    centro.direccion = direccion
    centro.distancia = distancia

    expect(centro.direccion).to eql direccion
    expect(centro.distancia).to eql distancia
  end
end
