require 'spec_helper'

describe 'Resumen' do
  before(:each) do
    @plan = Plan.new('Juventud', 1000)

    @afiliado = Afiliado.new('Juan Perez', @plan.id)

    @prestacion = Prestacion.new('Traumatologia', 10)
  end

  it 'deberia generar un costo adicional de cero cuando no se realizaron visitas' do
    visitas = []

    resumen = Resumen.new(@afiliado, @plan, visitas)

    expect(resumen.costo_adicional).to eq 0
  end

  it 'deberia generar un costo adicional del monto de la prestación cuando hay una visita' do
    visitas = [VisitaMedica.new(@afiliado.id, @prestacion)]

    resumen = Resumen.new(@afiliado, @plan, visitas)

    expect(resumen.costo_adicional).to eq 10
  end
end
