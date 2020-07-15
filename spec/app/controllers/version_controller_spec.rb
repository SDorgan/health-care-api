require 'spec_helper'

describe 'VersionController' do
  it 'deberia devoler la version actual' do
    get '/version'
    version = Version.current
    response = JSON.parse(last_response.body)
    expect(response['version']).to eq version
  end
end
