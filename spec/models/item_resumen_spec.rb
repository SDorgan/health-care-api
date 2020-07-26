require 'spec_helper'

describe 'ItemResumen' do
  xit 'deberia devolver sus atributos' do
    item_resumen = ItemResumen.new(nombre, fecha, costo)

    expect(item_resumen.nombre).to eq nombre
    expect(item_resumen.fecha).to eq fecha
    expect(item_resumen.costo).to eq costo
  end
end
