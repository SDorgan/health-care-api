require 'spec_helper'

describe 'CoberturaVisita' do
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

  it 'deberia devolver la cantidad con la que fue creada' do
    cobertura_visita = CoberturaVisita.new(0)

    expect(cobertura_visita.cantidad).to eq 0
  end

  it 'deberia devolver todas las visitas cuando la cantidad de cobertura es cero' do
    cobertura_visita = CoberturaVisita.new(0)

    visitas_filtradas = cobertura_visita.filtrar(visitas)

    expect(visitas_filtradas.length).to eq visitas.length
  end
end
