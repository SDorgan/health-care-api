require 'json'
require 'webmock/rspec'

def stub_send_location_centros(latitud, longitud, centros)
  result = []
  result << { 'latLng' => { 'lat': "#{latitud}", 'lng': "#{longitud}" } }
  centros.each do |centro|
    result << { 'latLng' => { 'lat': centro[:latitud], 'lng': centro[:longitud] } }
  end
  request = { 'locations': result }

  response = {
    "distance": [
      0,
      0.165,
      107.562
    ],
    "locations": [
      { "street": 'Leveroni' },
      { "street": '2282 Avenida del Libertador' },
      { "street": 'Ruta Nacional 205' }
    ],
    "info": {
      "statuscode": 0
    }
  }

  stub_request(:post, 'http://www.mapquestapi.com/directions/v2/routematrix?key=TEST_KEY')
    .with(
      body: JSON.dump(request),
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Content-Type'=>'application/json',
        'User-Agent'=>'Faraday v1.0.1'
      }
    )
    .to_return(status: 200, body: JSON.dump(response), headers: {})
end
