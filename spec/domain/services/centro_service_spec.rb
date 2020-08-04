require 'spec_helper'

describe 'CentroService' do
  describe 'Centros Cercanos' do
    let(:latitud_busqueda) do
      -34.447654
    end

    let(:longitud_busqueda) do
      -58.544412
    end

    let(:centro) do
      Centro.new('Hospital Alemán', -35.446324, -59.544443)
    end

    let(:centro_cercano) do
      Centro.new('Hospital Suizo', -34.446354, -58.544443)
    end

    before(:each) do
      @repo = CentroRepository.new
      @calculador_distancia = instance_double('CalculadorDistancia')
    end

    it 'debería devolver lista vacía si no hay centros' do
      respuesta = { 'distancias': [], 'direcciones': [] }
      allow(@calculador_distancia).to receive(:obtener_direcciones_a_punto).and_return(respuesta)

      centro_service = CentroService.new(@repo, @calculador_distancia)
      centros = centro_service.buscar(latitud: latitud_busqueda, longitud: longitud_busqueda)

      expect(centros.length).to be 0
    end

    xit 'debería devolver el único elemento existente' do # rubocop:disable RSpec/ExampleLength, RSpec/MultipleExpectations, Metrics/LineLength
      centro = @repo.save(centro)
      respuesta = { 'distancias': [107.562], 'direcciones': ['Ruta Nacional 205'] }

      allow(@calculador_distancia).to receive(:obtener_direcciones_a_punto).and_return(respuesta)

      centro_service = CentroService.new(CentroRepository.new, @calculador_distancia)
      centros = centro_service.buscar(@latitud_busqueda, @longitud_busqueda)

      expect(centros.length).to be 1
      expect(centros.first.id).to be centro.id
      expect(centros.first.distancia).to be 107.562
      expect(centros.first.direccion).to be 'Ruta Nacional 205'
    end

    xit 'debería devolver el elemento más cercano' do # rubocop:disable RSpec/ExampleLength
      _centro = @repo.save(centro)
      centro_cercano = @repo.save(centro_cercano)
      respuesta = { 'distancias': [107.562, 0.165], 'direcciones': ['Ruta Nacional 205', '2282 Avenida del Libertador'] } # rubocop:disable Metrics/LineLength

      allow(@calculador_distancia).to receive(:obtener_direcciones_a_punto).and_return(respuesta)

      centro_service = CentroService.new(CentroRepository.new, @calculador_distancia)
      centros = centro_service.buscar(@latitud_busqueda, @longitud_busqueda)

      expect(centros.length).to be 1
      expect(centros.first.id).to be centro_cercano.id
      expect(centros.first.distancia).to be 0.165
    end
  end
end
