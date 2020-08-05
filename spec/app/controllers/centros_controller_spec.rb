require 'spec_helper'
require 'erb'

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

  let(:longitud) do
    -58.544412
  end

  let(:prestacion) do
    { 'nombre' => 'Traumatología', 'costo' => 500 }
  end

  it 'deberia devolver un JSON con centros como clave' do
    get '/centros', {}, 'HTTP_API_KEY' => API_KEY
    last_response.body.include?('centros')
  end

  it 'deberia devolver un JSON con el centro cargado' do # rubocop:disable RSpec/ExampleLength,  RSpec/MultipleExpectations, Metrics/LineLength
    post '/centros', { 'nombre': centro_nombre, 'latitud': latitud, 'longitud': longitud }.to_json, 'HTTP_API_KEY' => API_KEY
    get '/centros', {}, 'HTTP_API_KEY' => API_KEY
    response = JSON.parse(last_response.body)
    expect(response['centros'].length).to eq 1
    expect(response['centros'][0]['nombre']).to eq centro_nombre
    expect(response['centros'][0]['latitud']).to eq latitud
    expect(response['centros'][0]['longitud']).to eq longitud
  end

  it 'deberia devolver el centro con el que se hizo POST' do
    post '/centros', { 'nombre': centro_nombre, 'latitud': latitud, 'longitud': longitud }.to_json, 'HTTP_API_KEY' => API_KEY
    response = JSON.parse(last_response.body)
    expect(response['centro']['nombre']).to eq centro_nombre
  end

  it 'deberia devolver un JSON con centros como clave al pedir centros de una prestacion' do
    post '/prestaciones', { 'nombre': prestacion['nombre'], 'costo': prestacion['costo'] }.to_json, 'HTTP_API_KEY' => API_KEY

    get "/centros?prestacion=#{ERB::Util.url_encode(prestacion['nombre'])}", {}, 'HTTP_API_KEY' => API_KEY
    last_response.body.include?('centros')
  end

  it 'si se le pasa una prestacion, deberia devolver los centros en los que se da una prestacion' do # rubocop:disable RSpec/ExampleLength, Metrics/LineLength
    centro_repo = CentroRepository.new
    @centro = centro_repo.save(Centro.new(centro_nombre, latitud, longitud))
    @otro_centro = centro_repo.save(Centro.new(otro_centro, latitud + 1, longitud + 1))

    prestacion_repo = PrestacionRepository.new
    @prestacion = prestacion_repo.save(Prestacion.new(prestacion['nombre'], prestacion['costo']))

    centro_repo.add_prestacion(@centro, @prestacion)

    get '/centros?prestacion=traumatologia', {}, 'HTTP_API_KEY' => API_KEY
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

    get "/centros?prestacion=#{ERB::Util.url_encode(@prestacion.nombre)}", {}, 'HTTP_API_KEY' => API_KEY
    response = JSON.parse(last_response.body)

    expect(response['centros'].length).to eq 1
  end

  it 'si se le pasa una prestacion, deberia devolver error si la prestacion no existe' do
    get '/centros?prestacion=PrestacionInexistente', {}, 'HTTP_API_KEY' => API_KEY

    expect(last_response.status).to be 404
    expect(last_response.body).to eq 'La prestación pedida no existe'
  end

  it 'deberia devolver error si no se especifica la latitud' do
    post '/centros', { 'nombre': centro_nombre, 'longitud': longitud }.to_json, 'HTTP_API_KEY' => API_KEY

    expect(last_response.status).to be 400
    expect(last_response.body).to eq 'No se pasó un par válido de coordenadas'
  end

  it 'deberia devolver error si no se especifica la longitud' do
    post '/centros', { 'nombre': centro_nombre, 'latitud': latitud }.to_json, 'HTTP_API_KEY' => API_KEY

    expect(last_response.status).to be 400
    expect(last_response.body).to eq 'No se pasó un par válido de coordenadas'
  end

  it 'si cargo un centro con nombre repetido, devuelve error' do
    post '/centros', { 'nombre': centro_nombre, 'latitud': latitud, 'longitud': longitud }.to_json, 'HTTP_API_KEY' => API_KEY
    post '/centros', { 'nombre': centro_nombre, 'latitud': latitud + 1, 'longitud': longitud + 1 }.to_json, 'HTTP_API_KEY' => API_KEY

    expect(last_response.status).to be 400
    expect(last_response.body).to eq 'El centro ingresado ya existe'
  end

  it 'si cargo un centro con coordenadas repetidas, devuelve error' do
    post '/centros', { 'nombre': centro_nombre, 'latitud': latitud, 'longitud': longitud }.to_json, 'HTTP_API_KEY' => API_KEY
    post '/centros', { 'nombre': otro_centro, 'latitud': latitud, 'longitud': longitud }.to_json, 'HTTP_API_KEY' => API_KEY

    expect(last_response.status).to be 400
    expect(last_response.body).to eq 'El centro ingresado ya existe'
  end

  xit 'debería traer el centro más cercano' do # rubocop:disable RSpec/ExampleLength, RSpec/MultipleExpectations, Metrics/LineLength
    post '/centros', { 'nombre': centro_nombre, 'latitud': latitud, 'longitud': longitud }.to_json, 'HTTP_API_KEY' => API_KEY
    # add webmock
    get "/centros?latitud=#{latitud}&longitud=#{longitud}", {}, 'HTTP_API_KEY' => API_KEY
    expect(last_response.status).to be 200

    response = JSON.parse(last_response.body)
    expect(response['centros'].length).to eq 1
    centro = response['centros'].first
    expect(centro['direccion']).not_to be nil
    expect(centro['distancia']).not_to be nil
  end

  xit 'debería devolver vacío si no hay centros cercanos' do
    get "/centros?latitud=#{latitud}&longitud=#{longitud}", {}, 'HTTP_API_KEY' => API_KEY

    response = JSON.parse(last_response.body)
    expect(response['centros'].length).to eq 0
  end
end
