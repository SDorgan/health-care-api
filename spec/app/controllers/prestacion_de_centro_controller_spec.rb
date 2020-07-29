require 'spec_helper'

describe 'PrestacionDeCentroController' do
  let(:centro) do
    Centro.new('Hospital Alemán', 10.0, 15.0)
  end

  let(:otro_centro) do
    Centro.new('Hospital Suizo', 12.0, 13.0)
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
    @otro_centro = centro_repo.save(otro_centro)

    prestacion_repo = PrestacionRepository.new
    @prestacion = prestacion_repo.save(prestacion)
    @otra_prestacion = prestacion_repo.save(otra_prestacion)

    centro_repo.add_prestacion_to_centro(@centro, @prestacion.id)
  end

  it 'deberia devolver un JSON con prestaciones como clave' do
    get "/centros/#{@centro.id}/prestaciones"
    last_response.body.include?('prestaciones')
  end

  it 'deberia devolver las prestaciones cargadas para un centro' do
    post "/centros/#{@centro.id}/prestaciones", { 'prestacion': @otra_prestacion.id }.to_json
    get "/centros/#{@centro.id}/prestaciones"
    response = JSON.parse(last_response.body)

    expect(response['prestaciones'].length).to eq 2
  end

  it 'deberia devolver ok al hacer el POST' do
    post "/centros/#{@centro.id}/prestaciones", { 'prestacion': @prestacion.id }.to_json
    last_response.body.include?('ok')
  end

  it 'deberia devolver error al hacer el POST con prestación inexistente' do
    pres_id = (@prestacion.id + @otra_prestacion.id + 1)
    post "/centros/#{@centro.id}/prestaciones", { 'prestacion': pres_id }.to_json
    last_response.body.include?('ok')
  end
end
