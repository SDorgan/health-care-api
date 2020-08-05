require 'spec_helper'
require 'erb'
require 'web_mock'

describe 'CentrosController' do
  let(:centro_nombre) do
    'Hospital Italiano'
  end

  let(:otro_centro) do
    'Hospital Suizo'
  end

  let(:latitud) do
    -34.44764
  end

  let(:latitud_buscada) do
    -34.54764
  end

  let(:longitud) do
    -58.544412
  end

  let(:longitud_buscada) do
    -58.564412
  end

  let(:prestacion) do
    { 'nombre' => 'Traumatología', 'costo' => 500 }
  end

  it 'deberia devolver un JSON con centros como clave' do
    get '/centros'
    last_response.body.include?('centros')
  end

  it 'deberia devolver un JSON con el centro cargado' do # rubocop:disable RSpec/ExampleLength,  RSpec/MultipleExpectations, Metrics/LineLength
    post '/centros', { 'nombre': centro_nombre, 'latitud': latitud, 'longitud': longitud }.to_json
    get '/centros'
    response = JSON.parse(last_response.body)
    expect(response['centros'].length).to eq 1
    expect(response['centros'][0]['nombre']).to eq centro_nombre
    expect(response['centros'][0]['latitud']).to eq latitud
    expect(response['centros'][0]['longitud']).to eq longitud
  end

  it 'deberia devolver el centro con el que se hizo POST' do
    post '/centros', { 'nombre': centro_nombre, 'latitud': latitud, 'longitud': longitud }.to_json
    response = JSON.parse(last_response.body)
    expect(response['centro']['nombre']).to eq centro_nombre
  end

  it 'deberia devolver un JSON con centros como clave al pedir centros de una prestacion' do
    post '/prestaciones', { 'nombre': prestacion['nombre'], 'costo': prestacion['costo'] }.to_json

    get "/centros?prestacion=#{ERB::Util.url_encode(prestacion['nombre'])}"
    last_response.body.include?('centros')
  end

  it 'si se le pasa una prestacion, deberia devolver los centros en los que se da una prestacion' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
    centro_repo = CentroRepository.new
    @centro = centro_repo.save(Centro.new(centro_nombre, latitud, longitud))
    @otro_centro = centro_repo.save(Centro.new(otro_centro, latitud + 1, longitud + 1))

    prestacion_repo = PrestacionRepository.new
    @prestacion = prestacion_repo.save(Prestacion.new(prestacion['nombre'], prestacion['costo']))

    centro_repo.add_prestacion(@centro, @prestacion)

    get '/centros?prestacion=traumatologia'
    response = JSON.parse(last_response.body)

    expect(response['centros'].length).to eq 1
  end

  it 'la prestacion para la que pide los centros debería poder hacer el pedido sin tildes o mayúsculas' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
    centro_repo = CentroRepository.new
    @centro = centro_repo.save(Centro.new(centro_nombre, latitud, longitud))
    @otro_centro = centro_repo.save(Centro.new(otro_centro, latitud + 1, longitud + 1))

    prestacion_repo = PrestacionRepository.new
    @prestacion = prestacion_repo.save(Prestacion.new(prestacion['nombre'], prestacion['costo']))

    centro_repo.add_prestacion(@centro, @prestacion)

    get "/centros?prestacion=#{ERB::Util.url_encode(@prestacion.nombre)}"
    response = JSON.parse(last_response.body)

    expect(response['centros'].length).to eq 1
  end

  it 'si se le pasa una prestacion, deberia devolver error si la prestacion no existe' do
    get '/centros?prestacion=PrestacionInexistente'

    expect(last_response.status).to be 404
    expect(last_response.body).to eq 'La prestación pedida no existe'
  end

  it 'deberia devolver error si no se especifica la latitud' do
    post '/centros', { 'nombre': centro_nombre, 'longitud': longitud }.to_json

    expect(last_response.status).to be 400
    expect(last_response.body).to eq 'No se pasó un par válido de coordenadas'
  end

  it 'deberia devolver error si no se especifica la longitud' do
    post '/centros', { 'nombre': centro_nombre, 'latitud': latitud }.to_json

    expect(last_response.status).to be 400
    expect(last_response.body).to eq 'No se pasó un par válido de coordenadas'
  end

  it 'si cargo un centro con nombre repetido, devuelve error' do
    post '/centros', { 'nombre': centro_nombre, 'latitud': latitud, 'longitud': longitud }.to_json
    post '/centros', { 'nombre': centro_nombre, 'latitud': latitud + 1, 'longitud': longitud + 1 }.to_json

    expect(last_response.status).to be 400
    expect(last_response.body).to eq 'El centro ingresado ya existe'
  end

  it 'si cargo un centro con coordenadas repetidas, devuelve error' do
    post '/centros', { 'nombre': centro_nombre, 'latitud': latitud, 'longitud': longitud }.to_json
    post '/centros', { 'nombre': otro_centro, 'latitud': latitud, 'longitud': longitud }.to_json

    expect(last_response.status).to be 400
    expect(last_response.body).to eq 'El centro ingresado ya existe'
  end

  it 'debería traer el centro más cercano' do
    centros = []
    post '/centros', { 'nombre': centro_nombre, 'latitud': latitud, 'longitud': longitud }.to_json
    centros << { 'latitud': latitud, 'longitud': longitud }

    stub_request(:get, "/centros?latitud=#{latitud_buscada}&longitud=#{longitud_buscada}")

    stub_send_location_centros(latitud_buscada, longitud_buscada, centros)
  end

  xit 'debería devolver vacío si no hay centros cercanos' do
    centros = []
    stub_request(:get, "/centros?latitud=#{latitud_buscada}&longitud=#{longitud_buscada}")

    stub_send_location_centros(latitud_buscada, longitud_buscada, centros)
  end
end
