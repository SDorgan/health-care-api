require 'spec_helper'

describe 'PrestacionDeCentroController' do
  let(:centro) do
    Centro.new('Hospital Alemán')
  end

  let(:otro_centro) do
    Centro.new('Hospital Suizo')
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

  it 'deberia devolver un JSON con centros como clave al pedir centros de una prestacion' do
    get "/prestaciones/#{@prestacion.id}/centros"
    last_response.body.include?('centros')
  end

  it 'deberia devolver los centros en los que se da una prestacion' do
    post "/centros/#{@otro_centro.id}/prestaciones", { 'prestacion': @prestacion.id }.to_json
    get "/prestaciones/#{@prestacion.id}/centros"
    response = JSON.parse(last_response.body)

    expect(response['centros'].length).to eq 2
  end

  it 'deberia devolver error si la prestacion no existe' do
    get "/prestaciones/#{@prestacion.id + @otra_prestacion.id + 1}/centros"

    expect(last_response.status).to be 404
    expect(last_response.body).to eq 'La prestación pedida no existe'
  end
end
