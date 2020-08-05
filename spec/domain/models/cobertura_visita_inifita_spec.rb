require 'spec_helper'

describe 'CoberturaVisitaInfinita' do
  let(:prestacion) do
    Prestacion.new('Traumatologia', 10)
  end

  let(:centro) do
    Centro.new('Hospital', 10.0, 12.0)
  end

  let(:visitas) do
    [
      VisitaMedica.new(1, prestacion, centro),
      VisitaMedica.new(1, prestacion, centro)
    ]
  end

  it 'deberia lanzar error si no se especifica el valor del copago' do
    expect { CoberturaVisitaInfinita.new(nil) }.to raise_error(PlanSinCopagoError)
  end

  it 'deberia lanzar error si el valor del copago es negativo' do
    expect { CoberturaVisitaInfinita.new(-10) }.to raise_error(PlanCopagoInvalido)
  end

  it 'deberia devolver el valor que simboliza el infinito' do
    copago = 0
    cobertura = CoberturaVisitaInfinita.new(copago)

    expect(cobertura.cantidad).to eq CoberturaVisitaInfinita::LIMITE
  end

  it 'deberia asignar un costo de cero a todas las visitas medicas realizadas' do
    copago = 0
    cobertura = CoberturaVisitaInfinita.new(copago)

    visitas_modificadas = cobertura.aplicar(visitas)

    expect(visitas_modificadas[0].costo).to eq 0
    expect(visitas_modificadas[1].costo).to eq 0
  end

  it 'deberia asignar un costo igual al copago a todas las visitas medicas realizadas' do
    copago = 10
    cobertura = CoberturaVisitaInfinita.new(copago)

    visitas_modificadas = cobertura.aplicar(visitas)

    expect(visitas_modificadas[0].costo).to eq copago
    expect(visitas_modificadas[1].costo).to eq copago
  end
end
