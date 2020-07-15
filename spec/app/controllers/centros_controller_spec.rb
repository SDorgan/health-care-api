require 'spec_helper'

describe 'CentrosController' do
  let(:centro_nombre) do
    'Hospital Italiano'
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
end
