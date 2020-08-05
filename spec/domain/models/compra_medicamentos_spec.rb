require 'spec_helper'

describe 'CompraMedicamentos' do
  it 'deberia devolver los datos con los que fue creada' do
    afiliado_id = 1
    visita_medica = CompraMedicamentos.new(afiliado_id, 500)

    expect(visita_medica.afiliado_id).to eql afiliado_id
    expect(visita_medica.monto).to be 500
  end
end
