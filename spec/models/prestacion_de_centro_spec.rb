require 'spec_helper'

describe 'PrestacionDeCentro' do
  let(:centro) do
    centro = Centro.new('Hospital Alemán')
    centro.id = 1

    centro
  end

  let(:prestacion) do
    prestacion = Prestacion.new('Traumatología', 1200)
    prestacion.id = 1

    prestacion
  end

  it 'deberia poder devolver los datos con los que fue creado' do
    prestacion_de_centro = PrestacionDeCentro.new(centro, prestacion)

    expect(prestacion_de_centro.centro_id).to eql centro.id
    expect(prestacion_de_centro.prestacion_id).to eql prestacion.id
  end
end
