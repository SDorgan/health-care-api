require 'spec_helper'

describe 'Afiliado' do
  let(:cantidad_visitas) do
    4
  end

  let(:copago) do
    100
  end

  let(:porcentaje_cobertura_medicamentos) do
    30
  end

  let(:cobertura_visitas) do
    CoberturaVisita.new(cantidad_visitas, copago)
  end

  let(:cobertura_medicamentos) do
    CoberturaMedicamentos.new(porcentaje_cobertura_medicamentos)
  end

  before(:each) do
    @plan = Plan.new(nombre: 'Neo',
                     costo: 1000,
                     cobertura_visitas: cobertura_visitas,
                     cobertura_medicamentos: cobertura_medicamentos,
                     edad_minima: 10,
                     edad_maxima: 99,
                     cantidad_hijos_maxima: 0,
                     conyuge: Plan::NO_ADMITE_CONYUGE)
    @plan.id = 1
  end

  # rubocop:disable RSpec/ExampleLength
  it 'deberia poder devolver los datos con los que fue creado' do
    nombre = 'Juan'
    id_telegram = '1'
    afiliado = Afiliado.new(nombre, @plan)
    afiliado.id_telegram = id_telegram

    expect(afiliado.nombre).to eql nombre
    expect(afiliado.id_telegram).to eql id_telegram
    expect(afiliado.plan.id).to eql @plan.id
  end
  # rubocop:enable RSpec/ExampleLength

  it 'deberia poder crear un afiliado sin id de telegram' do
    nombre = 'Juan'
    afiliado = Afiliado.new(nombre, @plan)

    expect(afiliado.id_telegram).to be_nil
  end

  it 'afiliado nuevo deberia ser no sospechoso covid' do
    nombre = 'Juan'
    afiliado = Afiliado.new(nombre, @plan)

    expect(afiliado.covid_sospechoso).to eq false
  end

  it 'afiliado debería poder ser sospechoso covid' do
    nombre = 'Juan'
    afiliado = Afiliado.new(nombre, @plan)
    afiliado.covid_sospechoso = true

    expect(afiliado.covid_sospechoso).to eq true
  end
end
