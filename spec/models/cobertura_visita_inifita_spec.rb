require 'spec_helper'

describe 'CoberturaVisitaInfinita' do
  it 'deberia devolver el valor que simboliza el infinito' do
    cobertura = CoberturaVisitaInfinita.new

    expect(cobertura.cantidad).to eq CoberturaVisitaInfinita::LIMITE
  end
end
