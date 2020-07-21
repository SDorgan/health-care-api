require 'spec_helper'

describe 'Resumen' do
  before(:each) do
    @plan = Plan.new('Juventud', 1000, 0, CoberturaVisita.new(0, 0))
    @plan.id = 1
    @plan_con_cobertura = Plan.new('Premium', 2000, 0, CoberturaVisita.new(2, 0))
    @plan_con_cobertura.id = 2
    @plan_infinito = Plan.new('Infinito', 5000, 0, CoberturaVisitaInfinita.new(0))
    @plan_con_cobertura.id = 3
    @plan_con_copago = Plan.new('Familiar', 3000, 0, CoberturaVisita.new(2, 10))
    @plan_con_copago.id = 4

    @afiliado = Afiliado.new('Juan Perez', @plan.id)
    @afiliado.id = 1
    @afiliado_premium = Afiliado.new('Pedro Gonzalez', @plan_con_cobertura.id)
    @afiliado_premium.id = 2
    @afiliado_infinito = Afiliado.new('Pedro Perez', @plan_infinito.id)
    @afiliado_infinito.id = 3
    @afiliado_copago = Afiliado.new('Juan Gonzalez', @plan_con_copago.id)
    @afiliado_copago.id = 4

    @prestacion = Prestacion.new('Traumatologia', 10)
    @otra_prestacion = Prestacion.new('Odontología', 20)

    @repo_planes = instance_double('PlanRepository')
    allow(@repo_planes).to receive(:find).with(@afiliado.plan_id).and_return(@plan)
    allow(@repo_planes).to receive(:find).with(@afiliado_premium.plan_id).and_return(@plan_con_cobertura) # rubocop:disable Metrics/LineLength
    allow(@repo_planes).to receive(:find).with(@afiliado_infinito.plan_id).and_return(@plan_infinito) # rubocop:disable Metrics/LineLength
    allow(@repo_planes).to receive(:find).with(@afiliado_copago.plan_id).and_return(@plan_con_copago) # rubocop:disable Metrics/LineLength
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
      visitas = [
        VisitaMedica.new(@afiliado.id, @prestacion),
        VisitaMedica.new(@afiliado_premium.id, @prestacion),
        VisitaMedica.new(@afiliado_copago.id, @prestacion)
      ]

      @repo_visitas = instance_double('VisitaMedicaRepository')
      allow(@repo_visitas).to receive(:find_by_afiliado).with(@afiliado.id).and_return([visitas[0]])
      allow(@repo_visitas).to receive(:find_by_afiliado).with(@afiliado_premium.id).and_return([visitas[1]]) # rubocop:disable Metrics/LineLength
      allow(@repo_visitas).to receive(:find_by_afiliado).with(@afiliado_copago.id).and_return([visitas[2]]) # rubocop:disable Metrics/LineLength
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

    it 'deberia cubrir la visita medica generando un costo adicional de cero' do
      resumen = Resumen.new(@afiliado_premium, @repo_planes, @repo_visitas)

      resumen.generar

      expect(resumen.costo_adicional).to eq 0
    end

    it 'deberia cubrir la visita medica generando un costo adicional igual al copago' do
      resumen = Resumen.new(@afiliado_copago, @repo_planes, @repo_visitas)

      resumen.generar

      expect(resumen.costo_adicional).to eq @plan_con_copago.cobertura_visitas.copago
    end
  end

  describe 'varias visitas medicas' do
    describe 'iguales' do
      before(:each) do
        visitas = [
          VisitaMedica.new(@afiliado.id, @prestacion),
          VisitaMedica.new(@afiliado.id, @prestacion)
        ]

        visitas_infinito = [
          VisitaMedica.new(@afiliado_infinito.id, @prestacion),
          VisitaMedica.new(@afiliado_infinito.id, @prestacion)
        ]

        visitas_copago = [
          VisitaMedica.new(@afiliado_copago.id, @prestacion),
          VisitaMedica.new(@afiliado_copago.id, @prestacion)
        ]

        @repo_visitas = instance_double('VisitaMedicaRepository')
        allow(@repo_visitas).to receive(:find_by_afiliado).with(@afiliado.id).and_return(visitas)
        allow(@repo_visitas).to receive(:find_by_afiliado).with(@afiliado_infinito.id).and_return(visitas_infinito) # rubocop:disable Metrics/LineLength
        allow(@repo_visitas).to receive(:find_by_afiliado).with(@afiliado_copago.id).and_return(visitas_copago) # rubocop:disable Metrics/LineLength
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

      it 'deberia generar un costo adicional de cero cuando el plan es infinito' do
        resumen = Resumen.new(@afiliado_infinito, @repo_planes, @repo_visitas)

        resumen.generar

        expect(resumen.costo_adicional).to eq 0
      end

      it 'deberia generar un total igual al monto del plan cuando tiene cobertura infinito' do # rubocop:disable Metrics/LineLength
        resumen = Resumen.new(@afiliado_infinito, @repo_planes, @repo_visitas)

        resumen.generar

        expect(resumen.total).to eq 5000
      end

      it 'deberia generar un costo adicional de dos copagos por cubrir cada visita' do
        resumen = Resumen.new(@afiliado_copago, @repo_planes, @repo_visitas)

        resumen.generar

        expect(resumen.costo_adicional).to eq @plan_con_copago.cobertura_visitas.copago * 2
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

      it 'deberia generar un costo con la suma de las dos distintas prestaciones' do
        resumen = Resumen.new(@afiliado, @repo_planes, @repo_visitas)

        resumen.generar

        expect(resumen.costo_adicional).to eq 30
      end

      it 'deberia generar un total igual al monto del plan mas la suma de las prestaciones' do
        resumen = Resumen.new(@afiliado, @repo_planes, @repo_visitas)

        resumen.generar

        expect(resumen.total).to eq 1030
      end
    end
  end
end
