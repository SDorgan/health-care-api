require 'spec_helper'

describe 'CoberturaVisita' do
  let(:afiliado) do
    Afiliado.new('Juan Perez', 1)
  end

  let(:prestacion) do
    Prestacion.new('Traumatologia', 10)
  end

  let(:centro) do
    Centro.new('Hospital', 10.0, 12.0)
  end

  let(:visitas) do
    [
      VisitaMedica.new(afiliado.id, prestacion, centro),
      VisitaMedica.new(afiliado.id, prestacion, centro)
    ]
  end

  let(:copago) { 0 }

  it 'deberia devolver la cantidad con la que fue creada' do
    cantidad = 0
    cobertura_visita = CoberturaVisita.new(cantidad, copago)

    expect(cobertura_visita.cantidad).to eq 0
  end

  it 'deberia devolver todas las visitas con costo igual al monto de la prestacion cuando la cobertura es cero' do # rubocop:disable Metrics/LineLength
    cantidad = 0
    cobertura_visita = CoberturaVisita.new(cantidad, copago)

    visitas_modificadas = cobertura_visita.aplicar(visitas)

    expect(visitas_modificadas[0].costo).to eq prestacion.costo
    expect(visitas_modificadas[1].costo).to eq prestacion.costo
  end

  it 'deberia cubrir una visita y asignar a la restante el costo de la prestacion cuando la cobertura es uno y copago es cero' do # rubocop:disable Metrics/LineLength
    cantidad = 1
    cobertura_visita = CoberturaVisita.new(cantidad, copago)

    visitas_modificadas = cobertura_visita.aplicar(visitas)

    expect(visitas_modificadas[0].costo).to eq 0
    expect(visitas_modificadas[1].costo).to eq prestacion.costo
  end

  it 'deberia cubrir una visita asignando el copago y a la restante el costo de la prestacion cuando la cobertura es uno' do # rubocop:disable Metrics/LineLength, RSpec/ExampleLength
    cantidad = 1
    copago = 10
    cobertura_visita = CoberturaVisita.new(cantidad, copago)

    visitas_modificadas = cobertura_visita.aplicar(visitas)

    expect(visitas_modificadas[0].costo).to eq copago
    expect(visitas_modificadas[1].costo).to eq prestacion.costo
  end

  it 'deberia cubrir ambas visitas cuando la cobertura es dos' do
    cantidad = 2
    cobertura_visita = CoberturaVisita.new(cantidad, copago)

    visitas_modificadas = cobertura_visita.aplicar(visitas)

    expect(visitas_modificadas[0].costo).to eq 0
    expect(visitas_modificadas[1].costo).to eq 0
  end

  it 'deberia cubrir ambas visitas cuando la cobertura es dos asignando el copago' do # rubocop:disable Metrics/LineLength, RSpec/ExampleLength
    cantidad = 2
    copago = 10
    cobertura_visita = CoberturaVisita.new(cantidad, copago)

    visitas_modificadas = cobertura_visita.aplicar(visitas)

    expect(visitas_modificadas[0].costo).to eq copago
    expect(visitas_modificadas[1].costo).to eq copago
  end

  it 'deberia cubrir todas las visitas si la cobertura supera la cantidad de visitas' do
    cantidad = 3
    cobertura_visita = CoberturaVisita.new(cantidad, copago)

    visitas_modificadas = cobertura_visita.aplicar(visitas)

    expect(visitas_modificadas[0].costo).to eq 0
    expect(visitas_modificadas[1].costo).to eq 0
  end

  it 'deberia cubrir todas las visitas si la cobertura supera la cantidad de visitas asignando el copago' do # rubocop:disable Metrics/LineLength, RSpec/ExampleLength
    cantidad = 3
    copago = 10
    cobertura_visita = CoberturaVisita.new(cantidad, copago)

    visitas_modificadas = cobertura_visita.aplicar(visitas)

    expect(visitas_modificadas[0].costo).to eq copago
    expect(visitas_modificadas[1].costo).to eq copago
  end
end
