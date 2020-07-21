require 'spec_helper'

describe 'CoberturaVisita' do
  it 'deberia devolver la cantidad con la que fue creada' do
    cobertura_visita = CoberturaVisita.new(0)

    expect(cobertura_visita.cantidad).to eq 0
  end
end
