require 'spec_helper'

describe 'CoberturaMedicamentos' do
  let(:compras) do
    [
      CompraMedicamentos.new(1, 600),
      CompraMedicamentos.new(1, 400)
    ]
  end

  it 'deberia lanzar error si no se especifica el valor de descuento' do
    expect { CoberturaMedicamentos.new(nil) }.to raise_error(PlanSinCoberturaMedicamentosError)
  end

  it 'deberia lanzar error si el valor especificado es negativo' do
    expect { CoberturaMedicamentos.new(-10) }.to raise_error(PlanCoberturaMedicamentosInvalida)
  end

  it 'deberia devolver el porcentaje de reembolzo con el que fue creado' do
    porcentaje = 0
    cobertura_medicamentos = CoberturaMedicamentos.new(porcentaje)

    expect(cobertura_medicamentos.porcentaje).to eq 0
  end

  it 'deberia devolver todas las compras con costo igual al monto de la compra cuando el porcentaje de cobertura es cero' do # rubocop:disable Metrics/LineLength
    porcentaje = 0
    cobertura_medicamentos = CoberturaMedicamentos.new(porcentaje)

    compras_modificadas = cobertura_medicamentos.aplicar(compras)

    expect(compras_modificadas[0].costo_final).to eq compras[0].monto
    expect(compras_modificadas[1].costo_final).to eq compras[1].monto
  end

  it 'deberia aplicar el porcentaje de cubertura a todas las compras de medicamentos' do # rubocop:disable Metrics/LineLength, RSpec/ExampleLength
    porcentaje = 50
    cobertura_medicamentos = CoberturaMedicamentos.new(porcentaje)

    compras_modificadas = cobertura_medicamentos.aplicar(compras)

    primer_monto = compras[0].monto * porcentaje / 100
    segundo_monto = compras[1].monto * porcentaje / 100
    expect(compras_modificadas[0].costo_final).to eq primer_monto
    expect(compras_modificadas[1].costo_final).to eq segundo_monto
  end
end
