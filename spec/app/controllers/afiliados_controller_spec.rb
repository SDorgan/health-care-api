require 'spec_helper'

describe 'AfiliadosController' do
  it 'deberia devoler los afiliados' do
    get '/afiliados'
    last_response.body.include?('afiliados')
  end
end
