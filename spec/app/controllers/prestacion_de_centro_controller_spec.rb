require 'spec_helper'

describe 'PrestacionDeCentroController' do
  let(:centro) do
    Centro.new('Hospital Alemán')
  end

  let(:prestacion) do
    Prestacion.new('Traumatología', 1200)
  end

  before(:each) do
    centro_repo = CentroRepository.new
    @centro = centro_repo.save(centro)

    prestacion_repo = PrestacionRepository.new
    @prestacion = prestacion_repo.save(prestacion)

    prestacion_de_hosp_aleman = PrestacionDeCentro.new(@centro, @prestacion)
    @repo = PrestacionDeCentroRepository.new

    @repo.save(prestacion_de_hosp_aleman)
  end

  it 'deberia devolver un JSON con prestaciones como clave' do
    get "/centros/#{@centro.id}/prestaciones"
    last_response.body.include?('prestaciones')
  end

  it 'deberia devolver ok al hacer el POST' do
    post "/centros/#{@centro.id}/prestaciones", { 'prestacion': 'Traumatología' }.to_json
    last_response.body.include?('ok')
  end
end
