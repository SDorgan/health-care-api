require 'spec_helper'

describe 'VisitaMedica' do
  let(:prestacion) do
    prestacion = Prestacion.new('Traumatología', 1200)
    prestacion.id = 1

    prestacion
  end

  it 'deberia devolver los datos con los que fue creada' do
    afiliado_id = 1
    visita_medica = VisitaMedica.new(afiliado_id, prestacion)

    expect(visita_medica.afiliado_id).to eql afiliado_id
    expect(visita_medica.prestacion.id).to eql prestacion.id
  end
end
