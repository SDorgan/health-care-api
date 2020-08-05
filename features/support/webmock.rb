require 'json'
require 'webmock/cucumber'

def stub_nearest_location(latitud, longitud, centros)
  centros = [] if centros.nil?
  result = []
  result << { 'latLng' => { 'lat': latitud.to_s, 'lng': longitud.to_s } }
  centros.each do |centro|
    result << { 'latLng' => { 'lat': centro[:latitud], 'lng': centro[:longitud] } }
  end
  _request = { 'locations': result }

  response = {
    "distance": [
      0,
      104.483,
      174.876,
      34.552,
      381.492
    ],
    "locations": [
      { "street": 'Lookup Street' },
      { "street": 'Street 1' },
      { "street": 'Street 2' },
      { "street": 'Street 3' },
      { "street": 'Street 4' }
    ],
    "info": {
      "statuscode": 0
    }
  }
  stub_request(:post, 'http://www.mapquestapi.com/directions/v2/routematrix?key=TEST_KEY')
    .to_return(status: 200, body: JSON.dump(response), headers: {})
end
