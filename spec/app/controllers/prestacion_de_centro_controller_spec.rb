require 'spec_helper'

describe 'PrestacionDeCentroController' do
  let(:centro) do
    Centro.new('Hospital Alemán')
  end

  let(:prestacion) do
    Prestacion.new('Traumatología', 1200)
  end

  let(:otra_prestacion) do
    Prestacion.new('Odontología', 1000)
  end

  before(:each) do
    centro_repo = CentroRepository.new
    @centro = centro_repo.save(centro)

    prestacion_repo = PrestacionRepository.new
    @prestacion = prestacion_repo.save(prestacion)
    @otra_prestacion = prestacion_repo.save(otra_prestacion)

    prestacion_de_hosp_aleman = PrestacionDeCentro.new(@centro, @prestacion)
    @repo = PrestacionDeCentroRepository.new

    @repo.save(prestacion_de_hosp_aleman)
  end

  it 'deberia devolver un JSON con prestaciones como clave' do
    get "/centros/#{@centro.id}/prestaciones"
    last_response.body.include?('prestaciones')
  end

  it 'deberia devolver las prestaciones cargadas para un centro' do
    post "/centros/#{@centro.id}/prestaciones", { 'prestacion': 'Odontología' }.to_json
    get "/centros/#{@centro.id}/prestaciones"
    response = JSON.parse(last_response.body)

    expect(response['prestaciones'].length).to eq 2
  end

  it 'deberia devolver ok al hacer el POST' do
    post "/centros/#{@centro.id}/prestaciones", { 'prestacion': 'Traumatología' }.to_json
    last_response.body.include?('ok')
  end
end
