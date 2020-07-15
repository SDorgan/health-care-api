require 'spec_helper'

describe 'Afiliado' do
  # rubocop:disable RSpec/ExampleLength
  it 'deberia poder devolver los datos con los que fue creado' do
    nombre = 'Juan'
    id_telegram = '1'
    plan_id = 10
    afiliado = Afiliado.new(nombre, plan_id)
    afiliado.id_telegram = id_telegram

    expect(afiliado.nombre).to eql nombre
    expect(afiliado.id_telegram).to eql id_telegram
    expect(afiliado.plan_id).to eql plan_id
  end
  # rubocop:enable RSpec/ExampleLength

  it 'deberia poder crear un afiliado sin id de telegram' do
    nombre = 'Juan'
    plan_id = 10
    afiliado = Afiliado.new(nombre, plan_id)

    expect(afiliado.id_telegram).to be_nil
  end

  it 'afiliado nuevo deberia ser no sospechoso covid' do
    nombre = 'Juan'
    plan_id = 10
    afiliado = Afiliado.new(nombre, plan_id)

    expect(afiliado.covid_sospechoso).to eq false
  end

  xit 'afiliado debería poder ser sospechoso covid' do
    nombre = 'Juan'
    plan_id = 10
    afiliado = Afiliado.new(nombre, plan_id)
    afiliado.covid_sospechoso = true

    expect(afiliado.covid_sospechoso).to eq true
  end
end
