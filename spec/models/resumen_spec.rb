require 'spec_helper'

describe 'Resumen' do
  before(:each) do
    @plan = Plan.new('Juventud', 1000, 0, 0, 0)

    @afiliado = Afiliado.new('Juan Perez', @plan.id)

    @prestacion = Prestacion.new('Traumatologia', 10)

    @otra_prestacion = Prestacion.new('Odontología', 20)
  end

  describe 'sin visitas medicas' do
    it 'deberia generar un costo adicional de cero' do
      visitas = []

      resumen = Resumen.new(@afiliado, @plan, visitas)

      expect(resumen.costo_adicional).to eq 0
    end

    it 'deberia generar un total igual al monto del plan' do
      visitas = []

      resumen = Resumen.new(@afiliado, @plan, visitas)

      expect(resumen.total).to eq 1000
    end
  end

  describe 'con visitas medicas' do
    it 'deberia generar un costo adicional del monto de la prestación cuando hay una visita' do
      visitas = [VisitaMedica.new(@afiliado.id, @prestacion)]

      resumen = Resumen.new(@afiliado, @plan, visitas)

      expect(resumen.costo_adicional).to eq 10
    end

    it 'deberia generar un total igual al monto del plan mas el precio de la prestacion' do
      visitas = [VisitaMedica.new(@afiliado.id, @prestacion)]

      resumen = Resumen.new(@afiliado, @plan, visitas)

      expect(resumen.total).to eq 1010
    end

    it 'deberia generar un costo adicional del doble del monto de la prestacion cuando hay dos visitas' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
      visitas = [
        VisitaMedica.new(@afiliado.id, @prestacion),
        VisitaMedica.new(@afiliado.id, @prestacion)
      ]

      resumen = Resumen.new(@afiliado, @plan, visitas)

      expect(resumen.costo_adicional).to eq 20
    end

    it 'deberia generar un total igual al monto del plan mas el doble del precio de la prestacion' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
      visitas = [
        VisitaMedica.new(@afiliado.id, @prestacion),
        VisitaMedica.new(@afiliado.id, @prestacion)
      ]

      resumen = Resumen.new(@afiliado, @plan, visitas)

      expect(resumen.total).to eq 1020
    end

    it 'deberia generar un costo con la suma de las dos distintas prestaciones' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
      visitas = [
        VisitaMedica.new(@afiliado.id, @prestacion),
        VisitaMedica.new(@afiliado.id, @otra_prestacion)
      ]

      resumen = Resumen.new(@afiliado, @plan, visitas)

      expect(resumen.costo_adicional).to eq 30
    end

    it 'deberia generar un total igual al monto del plan mas la suma de las prestaciones' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
      visitas = [
        VisitaMedica.new(@afiliado.id, @prestacion),
        VisitaMedica.new(@afiliado.id, @otra_prestacion)
      ]

      resumen = Resumen.new(@afiliado, @plan, visitas)

      expect(resumen.total).to eq 1030
    end
  end
end
