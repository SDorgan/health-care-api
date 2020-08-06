require 'spec_helper'

describe 'Resumen' do
  before(:each) do # rubocop:disable Metrics/BlockLength
    ENV['TEST_DATE'] = '12/03/2020'

    @plan = Plan.new(nombre: 'Juventud', costo: 1000,
                     cobertura_visitas: CoberturaVisita.new(0, 0),
                     cobertura_medicamentos: CoberturaMedicamentos.new(0),
                     cantidad_hijos_maxima: 1,
                     conyuge: Plan::ADMITE_CONYUGE,
                     edad_minima: 0, edad_maxima: 10)
    @plan.id = 1
    @plan_con_cobertura = Plan.new(nombre: 'Premium', costo: 2000,
                                   cobertura_visitas: CoberturaVisita.new(2, 0),
                                   cobertura_medicamentos: CoberturaMedicamentos.new(0),
                                   cantidad_hijos_maxima: 1,
                                   conyuge: Plan::ADMITE_CONYUGE,
                                   edad_minima: 0, edad_maxima: 10)
    @plan_con_cobertura.id = 2
    @plan_infinito = Plan.new(nombre: 'Infinito', costo: 5000,
                              cobertura_visitas: CoberturaVisitaInfinita.new(0),
                              cobertura_medicamentos: CoberturaMedicamentos.new(0),
                              cantidad_hijos_maxima: 1,
                              conyuge: Plan::ADMITE_CONYUGE,
                              edad_minima: 0, edad_maxima: 10)
    @plan_con_cobertura.id = 3
    @plan_con_copago = Plan.new(nombre: 'Familiar', costo: 3000,
                                cobertura_visitas: CoberturaVisita.new(2, 10),
                                cobertura_medicamentos: CoberturaMedicamentos.new(0),
                                cantidad_hijos_maxima: 1,
                                conyuge: Plan::ADMITE_CONYUGE,
                                edad_minima: 0, edad_maxima: 10)
    @plan_con_copago.id = 4
    @plan_con_medicamentos = Plan.new(nombre: 'Farmacia', costo: 1000,
                                      cobertura_visitas: CoberturaVisitaInfinita.new(0),
                                      cobertura_medicamentos: CoberturaMedicamentos.new(80),
                                      cantidad_hijos_maxima: 1,
                                      conyuge: Plan::ADMITE_CONYUGE,
                                      edad_minima: 0, edad_maxima: 10)
    @plan_con_medicamentos.id = 5
    @plan_con_cobertura_y_medicamentos = Plan.new(nombre: 'Completo', costo: 1000,
                                                  cobertura_visitas: CoberturaVisita.new(2, 5),
                                                  cobertura_medicamentos: CoberturaMedicamentos.new(50), # rubocop:disable Metrics/LineLength
                                                  cantidad_hijos_maxima: 1,
                                                  conyuge: Plan::ADMITE_CONYUGE,
                                                  edad_minima: 0, edad_maxima: 10)
    @plan_con_cobertura_y_medicamentos.id = 6

    @afiliado = Afiliado.new('Juan Perez', @plan)
    @afiliado.id = 1
    @afiliado_premium = Afiliado.new('Pedro Gonzalez', @plan_con_cobertura)
    @afiliado_premium.id = 2
    @afiliado_infinito = Afiliado.new('Pedro Perez', @plan_infinito)
    @afiliado_infinito.id = 3
    @afiliado_copago = Afiliado.new('Juan Gonzalez', @plan_con_copago)
    @afiliado_copago.id = 4
    @afiliado_medicamentos = Afiliado.new('Francisca Ramirez', @plan_con_medicamentos)
    @afiliado_medicamentos.id = 5
    @afiliado_cobertura_y_medicamentos = Afiliado.new('Mariana Flores', @plan_con_cobertura_y_medicamentos) # rubocop:disable Metrics/LineLength
    @afiliado_cobertura_y_medicamentos.id = 6

    @centro = Centro.new('Hospital', 10.0, 12.0)

    @prestacion = Prestacion.new('Traumatologia', 10)
    @otra_prestacion = Prestacion.new('Odontología', 20)
  end

  describe 'sin visitas medicas' do
    before(:each) do
      @repo_visitas = instance_double('VisitaMedicaRepository')
      allow(@repo_visitas).to receive(:find_by_afiliado).and_return([])

      @repo_compras = instance_double('CompraMedicamentosRepository')
      allow(@repo_compras).to receive(:find_by_afiliado).and_return([])
    end

    it 'deberia generar un costo adicional de cero' do
      resumen = Resumen.new(@afiliado, @repo_visitas, @repo_compras)

      resumen.generar

      expect(resumen.costo_adicional).to eq 0
    end

    it 'deberia generar un total igual al monto del plan' do
      resumen = Resumen.new(@afiliado, @repo_visitas, @repo_compras)

      resumen.generar

      expect(resumen.total).to eq 1000
    end
  end

  describe 'con una visita medica' do
    before(:each) do
      visitas = [
        VisitaMedica.new(@afiliado.id, @prestacion, @centro),
        VisitaMedica.new(@afiliado_premium.id, @prestacion, @centro),
        VisitaMedica.new(@afiliado_copago.id, @prestacion, @centro)
      ]

      @repo_visitas = instance_double('VisitaMedicaRepository')
      allow(@repo_visitas).to receive(:find_by_afiliado)
        .with(id: @afiliado.id, fecha: { inicio: DateManager.inicio_mes, fin: DateManager.fin_mes })
        .and_return([visitas[0]])
      allow(@repo_visitas).to receive(:find_by_afiliado)
        .with(id: @afiliado_premium.id, fecha: { inicio: DateManager.inicio_mes, fin: DateManager.fin_mes }) # rubocop:disable Metrics/LineLength
        .and_return([visitas[1]])
      allow(@repo_visitas).to receive(:find_by_afiliado)
        .with(id: @afiliado_copago.id, fecha: { inicio: DateManager.inicio_mes, fin: DateManager.fin_mes }) # rubocop:disable Metrics/LineLength
        .and_return([visitas[2]])

      @repo_compras = instance_double('CompraMedicamentosRepository')
      allow(@repo_compras).to receive(:find_by_afiliado).and_return([])
    end

    it 'deberia generar un costo adicional del monto de la prestación cuando hay una visita' do
      resumen = Resumen.new(@afiliado, @repo_visitas, @repo_compras)

      resumen.generar

      expect(resumen.costo_adicional).to eq 10
    end

    it 'deberia generar un total igual al monto del plan mas el precio de la prestacion' do
      resumen = Resumen.new(@afiliado, @repo_visitas, @repo_compras)

      resumen.generar

      expect(resumen.total).to eq 1010
    end

    it 'deberia cubrir la visita medica generando un costo adicional de cero' do
      resumen = Resumen.new(@afiliado_premium, @repo_visitas, @repo_compras)

      resumen.generar

      expect(resumen.costo_adicional).to eq 0
    end

    it 'deberia cubrir la visita medica generando un costo adicional igual al copago' do
      resumen = Resumen.new(@afiliado_copago, @repo_visitas, @repo_compras)

      resumen.generar

      expect(resumen.costo_adicional).to eq @plan_con_copago.cobertura_visitas.copago
    end
  end

  describe 'varias visitas medicas' do
    describe 'iguales' do
      before(:each) do
        visitas = [
          VisitaMedica.new(@afiliado.id, @prestacion, @centro),
          VisitaMedica.new(@afiliado.id, @prestacion, @centro)
        ]

        visitas_infinito = [
          VisitaMedica.new(@afiliado_infinito.id, @prestacion, @centro),
          VisitaMedica.new(@afiliado_infinito.id, @prestacion, @centro)
        ]

        visitas_copago = [
          VisitaMedica.new(@afiliado_copago.id, @prestacion, @centro),
          VisitaMedica.new(@afiliado_copago.id, @prestacion, @centro)
        ]

        @repo_visitas = instance_double('VisitaMedicaRepository')
        allow(@repo_visitas).to receive(:find_by_afiliado)
          .with(id: @afiliado.id, fecha: { inicio: DateManager.inicio_mes, fin: DateManager.fin_mes }) # rubocop:disable Metrics/LineLength
          .and_return(visitas)
        allow(@repo_visitas).to receive(:find_by_afiliado)
          .with(id: @afiliado_infinito.id, fecha: { inicio: DateManager.inicio_mes, fin: DateManager.fin_mes }) # rubocop:disable Metrics/LineLength
          .and_return(visitas_infinito)
        allow(@repo_visitas).to receive(:find_by_afiliado)
          .with(id: @afiliado_copago.id, fecha: { inicio: DateManager.inicio_mes, fin: DateManager.fin_mes }) # rubocop:disable Metrics/LineLength
          .and_return(visitas_copago)

        @repo_compras = instance_double('CompraMedicamentosRepository')
        allow(@repo_compras).to receive(:find_by_afiliado).and_return([])
      end

      it 'deberia generar un costo adicional del doble del monto de la prestacion cuando hay dos visitas' do # rubocop:disable Metrics/LineLength
        resumen = Resumen.new(@afiliado, @repo_visitas, @repo_compras)

        resumen.generar

        expect(resumen.costo_adicional).to eq 20
      end

      it 'deberia generar un total igual al monto del plan mas el doble del precio de la prestacion' do # rubocop:disable Metrics/LineLength
        resumen = Resumen.new(@afiliado, @repo_visitas, @repo_compras)

        resumen.generar

        expect(resumen.total).to eq 1020
      end

      it 'deberia generar un costo adicional de cero cuando el plan es infinito' do
        resumen = Resumen.new(@afiliado_infinito, @repo_visitas, @repo_compras)

        resumen.generar

        expect(resumen.costo_adicional).to eq 0
      end

      it 'deberia generar un total igual al monto del plan cuando tiene cobertura infinito' do # rubocop:disable Metrics/LineLength
        resumen = Resumen.new(@afiliado_infinito, @repo_visitas, @repo_compras)

        resumen.generar

        expect(resumen.total).to eq 5000
      end

      it 'deberia generar un costo adicional de dos copagos por cubrir cada visita' do
        resumen = Resumen.new(@afiliado_copago, @repo_visitas, @repo_compras)

        resumen.generar

        expect(resumen.costo_adicional).to eq @plan_con_copago.cobertura_visitas.copago * 2
      end
    end

    describe 'distintas' do
      before(:each) do
        visitas = [
          VisitaMedica.new(@afiliado.id, @prestacion, @centro),
          VisitaMedica.new(@afiliado.id, @otra_prestacion, @centro)
        ]

        @repo_visitas = instance_double('VisitaMedicaRepository')
        allow(@repo_visitas).to receive(:find_by_afiliado).and_return(visitas)

        @repo_compras = instance_double('CompraMedicamentosRepository')
        allow(@repo_compras).to receive(:find_by_afiliado).and_return([])
      end

      it 'deberia generar un costo con la suma de las dos distintas prestaciones' do
        resumen = Resumen.new(@afiliado, @repo_visitas, @repo_compras)

        resumen.generar

        expect(resumen.costo_adicional).to eq 30
      end

      it 'deberia generar un total igual al monto del plan mas la suma de las prestaciones' do
        resumen = Resumen.new(@afiliado, @repo_visitas, @repo_compras)

        resumen.generar

        expect(resumen.total).to eq 1030
      end
    end
  end

  describe 'cobertura de medicamentos' do
    before(:each) do
      compras = [
        CompraMedicamentos.new(@afiliado_medicamentos.id, 1000),
        CompraMedicamentos.new(@afiliado_medicamentos.id, 100),
        CompraMedicamentos.new(@afiliado_cobertura_y_medicamentos.id, 1000)
      ]

      @repo_compras = instance_double('CompraMedicamentosRepository')
      allow(@repo_compras).to receive(:find_by_afiliado)
        .with(id: @afiliado_medicamentos.id, fecha: { inicio: DateManager.inicio_mes, fin: DateManager.fin_mes }) # rubocop:disable Metrics/LineLength
        .and_return([compras[0], compras[1]])
      allow(@repo_compras).to receive(:find_by_afiliado)
        .with(id: @afiliado_cobertura_y_medicamentos.id, fecha: { inicio: DateManager.inicio_mes, fin: DateManager.fin_mes }) # rubocop:disable Metrics/LineLength
        .and_return([compras[2]])

      @repo_visitas = instance_double('VisitaMedicaRepository')
      allow(@repo_visitas).to receive(:find_by_afiliado).and_return([])
    end

    it 'deberia generar un costo adicional del monto de la compra con el descuento cuando hay una compra' do # rubocop:disable Metrics/LineLength
      resumen = Resumen.new(@afiliado_cobertura_y_medicamentos, @repo_visitas, @repo_compras) # rubocop:disable Metrics/LineLength

      resumen.generar

      expect(resumen.costo_adicional).to eq 500
    end

    it 'deberia generar un total igual al monto del plan mas el precio de la compra con el descuento' do # rubocop:disable Metrics/LineLength
      resumen = Resumen.new(@afiliado_cobertura_y_medicamentos, @repo_visitas, @repo_compras) # rubocop:disable Metrics/LineLength

      resumen.generar

      expect(resumen.total).to eq 1500
    end

    it 'deberia generar un costo adicional del monto de la compras con el descuento cuando hay múltiples compras' do # rubocop:disable Metrics/LineLength
      resumen = Resumen.new(@afiliado_medicamentos, @repo_visitas, @repo_compras)

      resumen.generar

      expect(resumen.costo_adicional).to eq 220
    end

    it 'deberia generar un total igual al monto del plan mas el precio de las compras con sus descuentos' do # rubocop:disable Metrics/LineLength
      resumen = Resumen.new(@afiliado_medicamentos, @repo_visitas, @repo_compras)

      resumen.generar

      expect(resumen.total).to eq 1220
    end
  end

  describe 'cobertura de medicamentos y visitas' do
    before(:each) do
      compras = [
        CompraMedicamentos.new(@afiliado_cobertura_y_medicamentos.id, 1000),
        CompraMedicamentos.new(@afiliado_cobertura_y_medicamentos.id, 500)
      ]

      @repo_compras = instance_double('CompraMedicamentosRepository')
      allow(@repo_compras).to receive(:find_by_afiliado)
        .with(id: @afiliado_cobertura_y_medicamentos.id, fecha: { inicio: DateManager.inicio_mes, fin: DateManager.fin_mes }) # rubocop:disable Metrics/LineLength
        .and_return([compras[0], compras[1]])

      visitas = [
        VisitaMedica.new(@afiliado_cobertura_y_medicamentos.id, @prestacion, @centro),
        VisitaMedica.new(@afiliado_cobertura_y_medicamentos.id, @prestacion, @centro),
        VisitaMedica.new(@afiliado_cobertura_y_medicamentos.id, @prestacion, @centro)
      ]

      @repo_visitas = instance_double('VisitaMedicaRepository')
      allow(@repo_visitas).to receive(:find_by_afiliado)
        .with(id: @afiliado_cobertura_y_medicamentos.id, fecha: { inicio: DateManager.inicio_mes, fin: DateManager.fin_mes }) # rubocop:disable Metrics/LineLength
        .and_return(visitas)
    end

    it 'deberia generar un costo adicional con las compras y visitas' do # rubocop:disable Metrics/LineLength
      resumen = Resumen.new(@afiliado_cobertura_y_medicamentos, @repo_visitas, @repo_compras) # rubocop:disable Metrics/LineLength

      resumen.generar

      expect(resumen.costo_adicional).to eq 770
    end

    it 'deberia generar un total con las compras, las visitas y el costo del plan' do # rubocop:disable Metrics/LineLength
      resumen = Resumen.new(@afiliado_cobertura_y_medicamentos, @repo_visitas, @repo_compras) # rubocop:disable Metrics/LineLength

      resumen.generar

      expect(resumen.total).to eq 1770
    end
  end

  describe 'items de resumen' do
    before(:each) do # rubocop:disable Metrics/BlockLength
      compras = [
        CompraMedicamentos.new(@afiliado_medicamentos.id, 1000),
        CompraMedicamentos.new(@afiliado_cobertura_y_medicamentos.id, 1000),
        CompraMedicamentos.new(@afiliado_cobertura_y_medicamentos.id, 500)
      ]

      @repo_compras = instance_double('CompraMedicamentosRepository')
      allow(@repo_compras).to receive(:find_by_afiliado)
        .with(id: @afiliado.id, fecha: { inicio: DateManager.inicio_mes, fin: DateManager.fin_mes })
        .and_return([])
      allow(@repo_compras).to receive(:find_by_afiliado)
        .with(id: @afiliado_premium.id, fecha: { inicio: DateManager.inicio_mes, fin: DateManager.fin_mes }) # rubocop:disable Metrics/LineLength
        .and_return([])
      allow(@repo_compras).to receive(:find_by_afiliado)
        .with(id: @afiliado_medicamentos.id, fecha: { inicio: DateManager.inicio_mes, fin: DateManager.fin_mes }) # rubocop:disable Metrics/LineLength
        .and_return([compras[0]])
      allow(@repo_compras).to receive(:find_by_afiliado)
        .with(id: @afiliado_cobertura_y_medicamentos.id, fecha: { inicio: DateManager.inicio_mes, fin: DateManager.fin_mes }) # rubocop:disable Metrics/LineLength
        .and_return([compras[1], compras[2]])

      visitas = [
        VisitaMedica.new(@afiliado_premium.id, @prestacion, @centro),
        VisitaMedica.new(@afiliado_cobertura_y_medicamentos.id, @prestacion, @centro),
        VisitaMedica.new(@afiliado_cobertura_y_medicamentos.id, @prestacion, @centro),
        VisitaMedica.new(@afiliado_cobertura_y_medicamentos.id, @prestacion, @centro)
      ]

      @repo_visitas = instance_double('VisitaMedicaRepository')
      allow(@repo_visitas).to receive(:find_by_afiliado)
        .with(id: @afiliado.id, fecha: { inicio: DateManager.inicio_mes, fin: DateManager.fin_mes })
        .and_return([])
      allow(@repo_visitas).to receive(:find_by_afiliado)
        .with(id: @afiliado_medicamentos.id, fecha: { inicio: DateManager.inicio_mes, fin: DateManager.fin_mes }) # rubocop:disable Metrics/LineLength
        .and_return([])
      allow(@repo_visitas).to receive(:find_by_afiliado)
        .with(id: @afiliado_premium.id, fecha: { inicio: DateManager.inicio_mes, fin: DateManager.fin_mes }) # rubocop:disable Metrics/LineLength
        .and_return([visitas[0]])
      allow(@repo_visitas).to receive(:find_by_afiliado)
        .with(id: @afiliado_cobertura_y_medicamentos.id, fecha: { inicio: DateManager.inicio_mes, fin: DateManager.fin_mes }) # rubocop:disable Metrics/LineLength
        .and_return([visitas[1], visitas[2], visitas[3]])
    end

    it 'resumen vacio no deberia tener items' do
      resumen = Resumen.new(@afiliado, @repo_visitas, @repo_compras)

      resumen.generar

      expect(resumen.items.length).to eq 0
    end

    it 'resumen tiene item de visita' do # rubocop:disable RSpec/ExampleLength
      resumen = Resumen.new(@afiliado_premium, @repo_visitas, @repo_compras)
      resumen.generar
      items = resumen.items
      expect(items.length).to eq 1
      expect(items[0].concepto.include?(@prestacion.nombre)).to eq true
      expect(items[0].concepto.include?(@centro.nombre)).to eq true
    end

    it 'resumen tiene item de medicamentos' do
      resumen = Resumen.new(@afiliado_medicamentos, @repo_visitas, @repo_compras)

      resumen.generar
      items = resumen.items

      expect(items.length).to eq 1
      expect(items[0].concepto.include?('Medicamentos')).to eq true
    end

    it 'resumen tiene muchos items' do
      resumen = Resumen.new(@afiliado_cobertura_y_medicamentos, @repo_visitas, @repo_compras) # rubocop:disable Metrics/LineLength

      resumen.generar

      expect(resumen.items.length).to eq 5
    end
  end
end
