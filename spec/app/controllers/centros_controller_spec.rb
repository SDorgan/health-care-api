require 'spec_helper'

describe 'CentrosController' do
  let(:centro_nombre) do
    'Hospital Italiano'
  end

  let(:otro_centro) do
    'Hospital Suizo'
  end

  let(:prestacion) do
    { 'nombre' => 'Traumatologia', 'costo' => 500 }
  end

  it 'deberia devolver un JSON con centros como clave' do
    get '/centros'
    last_response.body.include?('centros')
  end

  it 'deberia devolver un JSON con el centro cargado' do
    post '/centros', { 'nombre': centro_nombre }.to_json
    get '/centros'
    response = JSON.parse(last_response.body)
    expect(response['centros'].length).to eq 1
    expect(response['centros'][0]['nombre']).to eq centro_nombre
  end

  it 'deberia devolver el centro con el que se hizo POST' do
    post '/centros', { 'nombre': centro_nombre }.to_json
    response = JSON.parse(last_response.body)
    expect(response['centro']['nombre']).to eq centro_nombre
  end

  it 'deberia devolver un JSON con centros como clave al pedir centros de una prestacion' do
    post '/prestaciones', { 'nombre': prestacion['nombre'], 'costo': prestacion['costo'] }.to_json

    get "/centros?prestacion=#{prestacion['nombre']}"
    last_response.body.include?('centros')
  end

  it 'si se le pasa una prestacion, deberia devolver los centros en los que se da una prestacion' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
    centro_repo = CentroRepository.new
    @centro = centro_repo.save(Centro.new(centro_nombre))
    @otro_centro = centro_repo.save(Centro.new(otro_centro))

    prestacion_repo = PrestacionRepository.new
    @prestacion = prestacion_repo.save(Prestacion.new(prestacion['nombre'], prestacion['costo']))

    centro_repo.add_prestacion_to_centro(@centro, @prestacion.id)

    get "/centros?prestacion=#{@prestacion.nombre}"
    response = JSON.parse(last_response.body)

    expect(response['centros'].length).to eq 1
  end

  it 'si se le pasa una prestacion, deberia devolver error si la prestacion no existe' do
    get '/centros?prestacion=PrestacionInexistente'

    expect(last_response.status).to be 404
    expect(last_response.body).to eq 'La prestación pedida no existe'
  end
end
