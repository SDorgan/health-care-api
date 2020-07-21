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

  it 'deberia devolver todas las visitas con costo igual al monto de la prestacion cuando la cobertura es cero' do # rubocop:disable Metrics/LineLength
    cobertura_visita = CoberturaVisita.new(0)

    visitas_modificadas = cobertura_visita.aplicar(visitas)

    expect(visitas_modificadas[0].costo).to eq prestacion.costo
    expect(visitas_modificadas[1].costo).to eq prestacion.costo
  end

  it 'deberia cubri una visita y asignar a la restante el costo de la prestacion cuando la cobertura es uno' do # rubocop:disable Metrics/LineLength
    cobertura_visita = CoberturaVisita.new(1)

    visitas_modificadas = cobertura_visita.aplicar(visitas)

    expect(visitas_modificadas[0].costo).to eq 0
    expect(visitas_modificadas[1].costo).to eq prestacion.costo
  end

  it 'deberia cubrir ambas visitas cuando la cobertura es dos' do
    cobertura_visita = CoberturaVisita.new(2)

    visitas_modificadas = cobertura_visita.aplicar(visitas)

    expect(visitas_modificadas[0].costo).to eq 0
    expect(visitas_modificadas[1].costo).to eq 0
  end

  it 'deberia cubrir todas las visitas si la cobertura supera la cantidad de visitas' do
    cobertura_visita = CoberturaVisita.new(3)

    visitas_modificadas = cobertura_visita.aplicar(visitas)

    expect(visitas_modificadas[0].costo).to eq 0
    expect(visitas_modificadas[1].costo).to eq 0
  end
end
