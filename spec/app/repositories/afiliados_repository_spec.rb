require 'integration_spec_helper'

describe 'AfiliadoRepository' do
  before(:each) do
    @afiliado = Afiliado.new('Juan', 10)
    @repo = AfiliadoRepository.new
  end

  it 'deberia obtener el afiliado luego guardarse' do # rubocop:disable RSpec/ExampleLength
    @afiliado.id_telegram = '1'
    @repo = AfiliadoRepository.new

    @afiliado = @repo.save(@afiliado)
    afiliado_obtenido = @repo.all
    expect(afiliado_obtenido.first.nombre).to eq @afiliado.nombre
    expect(afiliado_obtenido.first.id_telegram).to eq @afiliado.id_telegram
    expect(afiliado_obtenido.first.id_plan).to eq @afiliado.id_plan
  end

  it 'deberia poder guardar afiliado sin id telegram' do
    @repo = AfiliadoRepository.new

    @afiliado = @repo.save(@afiliado)
    afiliado_obtenido = @repo.all
    expect(afiliado_obtenido.first.nombre).to eq @afiliado.nombre
    expect(afiliado_obtenido.first.id_telegram).to eq ''
  end
end
