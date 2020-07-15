require 'spec_helper'

describe 'CentrosController' do
  it 'deberia devolver el centro con el que se hizo POST' do
    centro_nombre = 'Hospital Italiano'
    post '/centros', { 'nombre': centro_nombre }.to_json
    response = JSON.parse(last_response.body)
    expect(response['centro']['nombre']).to eq centro_nombre
  end
end
