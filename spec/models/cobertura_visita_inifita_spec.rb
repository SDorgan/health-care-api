require 'spec_helper'

describe 'CoberturaVisitaInfinita' do
  let(:plan) do
    plan = Plan.new(nombre: 'PlanJuventud',
                    costo: 100,
                    cobertura_visitas: CoberturaVisita.new(0, 0),
                    cobertura_medicamentos: CoberturaMedicamentos.new(0),
                    edad_minima: 1, edad_maxima: 40, cantidad_hijos_maxima: 0,
                    conyuge: Plan::NO_ADMITE_CONYUGE)

    plan
  end

  let(:afiliado) do
    Afiliado.new('Juan Perez', plan)
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
