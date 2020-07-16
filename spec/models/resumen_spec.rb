require 'spec_helper'

describe 'Resumen' do
  before(:each) do
    @plan = Plan.new('Juventud', 1000)

    @afiliado = Afiliado.new('Juan Perez', @plan.id)

    @prestacion = Prestacion.new('Traumatologia', 10)

    @otra_prestacion = Prestacion.new('Odontología', 20)
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

  it 'deberia generar un costo adicional del doble del monto de la prestacion cuando hay dos visitas' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
    visitas = [
      VisitaMedica.new(@afiliado.id, @prestacion),
      VisitaMedica.new(@afiliado.id, @prestacion)
    ]

    resumen = Resumen.new(@afiliado, @plan, visitas)

    expect(resumen.costo_adicional).to eq 20
  end

  it 'deberia generar un costo con la suma de las dos distintas prestaciones' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
    visitas = [
      VisitaMedica.new(@afiliado.id, @prestacion),
      VisitaMedica.new(@afiliado.id, @otra_prestacion)
    ]

    resumen = Resumen.new(@afiliado, @plan, visitas)

    expect(resumen.costo_adicional).to eq 30
  end
end
