require 'spec_helper'

describe 'CoberturaVisitaInfinita' do
  let(:plan) do
    Plan.new('Juventud', 1000, 0, 0, 0)
  end

  let(:afiliado) do
    Afiliado.new('Juan Perez', plan.id)
  end

  let(:prestacion) do
    Prestacion.new('Traumatologia', 10)
  end

  let(:visitas) do
    [
      VisitaMedica.new(afiliado.id, prestacion),
      VisitaMedica.new(afiliado.id, prestacion)
    ]
  end

  it 'deberia devolver el valor que simboliza el infinito' do
    cobertura = CoberturaVisitaInfinita.new

    expect(cobertura.cantidad).to eq CoberturaVisitaInfinita::LIMITE
  end

  it 'deberia asignar un costo de cero a todas las visitas medicas realizadas' do
    cobertura = CoberturaVisitaInfinita.new

    visitas_modificadas = cobertura.aplicar(visitas)

    expect(visitas_modificadas[0].costo).to eq 0
    expect(visitas_modificadas[1].costo).to eq 0
  end
end
