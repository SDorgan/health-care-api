require 'spec_helper'

describe 'Resumen' do
  before(:each) do
    @plan = Plan.new('Juventud', 1000)

    @afiliado = Afiliado.new('Juan Perez', @plan.id)
  end

  it 'deberia generar un costo adicional de cero cuando no se realizaron visitas' do
    visitas = []

    resumen = Resumen.new(@afiliado, @plan, visitas)

    expect(resumen.costo_adicional).to eq 0
  end
end
