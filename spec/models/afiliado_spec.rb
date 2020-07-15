require 'spec_helper'

describe 'Afiliado' do
  # rubocop:disable RSpec/ExampleLength
  it 'deberia poder devolver los datos con los que fue creado' do
    nombre = 'Juan'
    id_telegram = '1'
    id_plan = 10
    afiliado = Afiliado.new(nombre, id_telegram, id_plan)

    expect(afiliado.nombre).to eql nombre
    expect(afiliado.id_telegram).to eql id_telegram
    expect(afiliado.id_plan).to eql id_plan
  end
  # rubocop:enable RSpec/ExampleLength
end
