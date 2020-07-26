require 'spec_helper'

describe 'ItemResumen' do
  it 'deberia devolver sus atributos' do # rubocop:disable RSpec/ExampleLength
    concepto = 'Traumatologia - Hospital Aleman'
    fecha = '01/01/2020'
    costo = '$500'
    item_resumen = ItemResumen.new(concepto, fecha, costo)

    expect(item_resumen.concepto).to eq concepto
    expect(item_resumen.fecha).to eq fecha
    expect(item_resumen.costo).to eq costo
  end
end
