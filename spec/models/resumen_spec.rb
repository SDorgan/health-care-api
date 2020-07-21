require 'spec_helper'

describe 'Resumen' do
  before(:each) do
    @plan = Plan.new('Juventud', 1000, 0, 0, 0)

    @afiliado = Afiliado.new('Juan Perez', @plan.id)

    @prestacion = Prestacion.new('Traumatologia', 10)
    @otra_prestacion = Prestacion.new('Odontología', 20)

    @repo_planes = instance_double('PlanRepository')
    allow(@repo_planes).to receive(:find) do
      @plan
    end
  end

  describe 'sin visitas medicas' do
    before(:each) do
      @repo_visitas = instance_double('VisitaMedicaRepository')
      allow(@repo_visitas).to receive(:find_by_afiliado).and_return([])
    end

    it 'deberia generar un costo adicional de cero' do
      resumen = Resumen.new(@afiliado, @repo_planes, @repo_visitas)

      resumen.generar

      expect(resumen.costo_adicional).to eq 0
    end

    it 'deberia generar un total igual al monto del plan' do
      resumen = Resumen.new(@afiliado, @repo_planes, @repo_visitas)

      resumen.generar

      expect(resumen.total).to eq 1000
    end
  end

  describe 'con una visita medica' do
    before(:each) do
      visitas = [VisitaMedica.new(@afiliado.id, @prestacion)]

      @repo_visitas = instance_double('VisitaMedicaRepository')
      allow(@repo_visitas).to receive(:find_by_afiliado).and_return(visitas)
    end

    it 'deberia generar un costo adicional del monto de la prestación cuando hay una visita' do
      resumen = Resumen.new(@afiliado, @repo_planes, @repo_visitas)

      resumen.generar

      expect(resumen.costo_adicional).to eq 10
    end

    it 'deberia generar un total igual al monto del plan mas el precio de la prestacion' do
      resumen = Resumen.new(@afiliado, @repo_planes, @repo_visitas)

      resumen.generar

      expect(resumen.total).to eq 1010
    end
  end

  describe 'varias visitas medicas' do
    describe 'iguales' do
      before(:each) do
        visitas = [
          VisitaMedica.new(@afiliado.id, @prestacion),
          VisitaMedica.new(@afiliado.id, @prestacion)
        ]

        @repo_visitas = instance_double('VisitaMedicaRepository')
        allow(@repo_visitas).to receive(:find_by_afiliado).and_return(visitas)
      end

      it 'deberia generar un costo adicional del doble del monto de la prestacion cuando hay dos visitas' do # rubocop:disable Metrics/LineLength
        resumen = Resumen.new(@afiliado, @repo_planes, @repo_visitas)

        resumen.generar

        expect(resumen.costo_adicional).to eq 20
      end

      it 'deberia generar un total igual al monto del plan mas el doble del precio de la prestacion' do # rubocop:disable Metrics/LineLength
        resumen = Resumen.new(@afiliado, @repo_planes, @repo_visitas)

        resumen.generar

        expect(resumen.total).to eq 1020
      end
    end

    describe 'distintas' do
      before(:each) do
        visitas = [
          VisitaMedica.new(@afiliado.id, @prestacion),
          VisitaMedica.new(@afiliado.id, @otra_prestacion)
        ]

        @repo_visitas = instance_double('VisitaMedicaRepository')
        allow(@repo_visitas).to receive(:find_by_afiliado).and_return(visitas)
      end

      it 'deberia generar un costo con la suma de las dos distintas prestaciones' do # rubocop:disable Metrics/LineLength
        resumen = Resumen.new(@afiliado, @repo_planes, @repo_visitas)

        resumen.generar

        expect(resumen.costo_adicional).to eq 30
      end

      it 'deberia generar un total igual al monto del plan mas la suma de las prestaciones' do # rubocop:disable Metrics/LineLength
        resumen = Resumen.new(@afiliado, @repo_planes, @repo_visitas)

        resumen.generar

        expect(resumen.total).to eq 1030
      end
    end
  end
end
