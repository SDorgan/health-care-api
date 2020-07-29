Dado('el plan con nombre {string}') do |nombre_plan|
  @request = {
    'nombre': nombre_plan
  }

  @response = Faraday.post(PLANES_URL, @request.to_json, 'Content-Type' => 'application/json')
end

Cuando('consulto los planes disponibles') do
  @response = Faraday.get(PLANES_URL, 'Content-Type' => 'application/json')
end

Entonces('obtengo el plan con nombre {string}') do |nombre_plan|
  json_response = JSON.parse(@response.body)
  planes = json_response['planes']

  nombres = planes.map { |plan| plan['nombre'] }

  expect(nombres.include?(nombre_plan)).to eq true
end

Dado('el plan con nombre {string} con costo unitario ${int}') do |nombre_plan, costo|
  @request = {
    'nombre' => nombre_plan,
    'costo' => costo
  }
end

Cuando('se registra el plan') do
  @response = Faraday.post(PLANES_URL, @request.to_json, 'Content-Type' => 'application/json')
  json_response = JSON.parse(@response.body)
  plan = json_response['plan']
  @plan_id = plan['id']
end

Entonces('se registra exitosamente') do
  expect(@response.status).to eq 201
end

Dado('cobertura de visitas con límite {int}') do |limite_visitas|
  @request = {
    'nombre' => @request['nombre'],
    'costo' => @request['costo'],
    'limite_cobertura_visitas' => limite_visitas,
    'cobertura_medicamentos' => 0
  }
end

Dado('cobertura de visitas con límite infinito') do
  @request = {
    'nombre' => @request['nombre'],
    'costo' => @request['costo'],
    'copago' => 0,
    'cobertura_medicamentos' => 0,
    'edad_minima' => 15,
    'edad_maxima' => 30,
    'cantidad_hijos_maxima' => 0,
    'conyuge' => 'NO_ADMITE_CONYUGE'
  }
end

Dado('cobertura de visitas con copago ${int} y con límite infinito') do |copago|
  @request = {
    'nombre' => @request['nombre'],
    'costo' => @request['costo'],
    'copago' => copago,
    'cobertura_medicamentos' => 0,
    'edad_minima' => 15,
    'edad_maxima' => 30,
    'cantidad_hijos_maxima' => 0,
    'conyuge' => 'NO_ADMITE_CONYUGE'
  }
end

Dado('cobertura de visitas con copago ${int} y con límite {int}') do |copago, limite_visitas|
  @request = {
    'nombre' => @request['nombre'],
    'costo' => @request['costo'],
    'limite_cobertura_visitas' => limite_visitas,
    'copago' => copago,
    'cobertura_medicamentos' => 0
  }
end

Dado('cobertura de visitas con copago ${int} y con límite {int} y medicamentos {int}%') do |copago, limite_visitas, cobertura_medicamentos| # rubocop:disable Metrics/LineLength
  @request = {
    'nombre' => @request['nombre'],
    'costo' => @request['costo'],
    'limite_cobertura_visitas' => limite_visitas,
    'copago' => copago,
    'cobertura_medicamentos' => cobertura_medicamentos
  }
end

Dado('cobertura de medicamentos {int}%') do |cobertura|
  @request = {
    'nombre' => @request['nombre'],
    'costo' => @request['costo'],
    'limite_cobertura_visitas' => @request['limite_cobertura_visitas'],
    'copago' => @request['copago'],
    'cobertura_medicamentos' => cobertura,
    'edad_minima' => @edad_minima,
    'edad_maxima' => @edad_maxima,
    'cantidad_hijos_maxima' => @cantidad_hijos_maxima,
    'conyuge' => @conyuge
  }
end

Dado('restricciones edad min {int}, edad max {int}, hijos max {int}, admite conyuge {string}') do |edad_minima, edad_maxima, cantidad_hijos_maxima, conyuge| # rubocop:disable  Metrics/LineLength
  conyuge = if conyuge.eql? 'si'
              'ADMITE_CONYUGE'
            else
              'NO_ADMITE_CONYUGE'
            end
  @edad_minima = edad_minima
  @edad_maxima = edad_maxima
  @cantidad_hijos_maxima = cantidad_hijos_maxima
  @conyuge = conyuge
  @request = {
    'nombre' => @request['nombre'],
    'costo' => @request['costo'],
    'limite_cobertura_visitas' => @request['limite_cobertura_visitas'],
    'copago' => @request['copago'],
    'cobertura_medicamentos' => @request['cobertura_medicamentos'],
    'edad_minima' => @edad_minima,
    'edad_maxima' => @edad_maxima,
    'cantidad_hijos_maxima' => @cantidad_hijos_maxima,
    'conyuge' => @conyuge
  }
end

Dado('restricciones edad min {int}, edad max {int}, hijos max {int}, requiere conyuge {string}') do |edad_minima, edad_maxima, cantidad_hijos_maxima, conyuge| # rubocop:disable  Metrics/LineLength
  conyuge = if conyuge.eql? 'si'
              'REQUIERE_CONYUGE'
            else
              'ADMITE_CONYUGE'
            end
  @edad_minima = edad_minima
  @edad_maxima = edad_maxima
  @cantidad_hijos_maxima = cantidad_hijos_maxima
  @conyuge = conyuge
  @request = {
    'nombre' => @request['nombre'],
    'costo' => @request['costo'],
    'limite_cobertura_visitas' => @request['limite_cobertura_visitas'],
    'copago' => @request['copago'],
    'cobertura_medicamentos' => @request['cobertura'],
    'edad_minima' => @edad_minima,
    'edad_maxima' => @edad_maxima,
    'cantidad_hijos_maxima' => @cantidad_hijos_maxima,
    'conyuge' => @conyuge
  }
end

Cuando('se registra el plan invalido') do
  @response = Faraday.post(PLANES_URL, @request.to_json, 'Content-Type' => 'application/json')
end

Dado('el plan con costo unitario ${int}') do |costo|
  @request = {
    'costo' => costo
  }
end

Dado('restricciones hijos max {int}, admite conyuge {string}') do |cantidad_hijos_maxima, conyuge|
  conyuge = if conyuge.eql? 'si'
              'REQUIERE_CONYUGE'
            else
              'ADMITE_CONYUGE'
            end
  @request = {
    'nombre' => @request['nombre'],
    'costo' => @request['costo'],
    'limite_cobertura_visitas' => @request['limite_cobertura_visitas'],
    'copago' => @request['copago'],
    'cobertura_medicamentos' => @request['cobertura'],
    'cantidad_hijos_maxima' => cantidad_hijos_maxima,
    'conyuge' => conyuge
  }
end

Dado('restricciones edad min {int}, edad max {int}, admite conyuge {string}') do |edad_minima, edad_maxima, conyuge| # rubocop:disable  Metrics/LineLength
  conyuge = if conyuge.eql? 'si'
              'REQUIERE_CONYUGE'
            else
              'ADMITE_CONYUGE'
            end
  @request = {
    'nombre' => @request['nombre'],
    'costo' => @request['costo'],
    'cobertura_medicamentos' => @request['cobertura'],
    'limite_cobertura_visitas' => @request['limite_cobertura_visitas'],
    'copago' => @request['copago'],
    'edad_minima' => edad_minima,
    'edad_maxima' => edad_maxima,
    'conyuge' => conyuge
  }
end

Dado('restricciones edad min {int}, edad max {int}, hijos max {int}') do |edad_minima, edad_maxima, cantidad_hijos_maxima| # rubocop:disable  Metrics/LineLength
  @request = {
    'nombre' => @request['nombre'],
    'costo' => @request['costo'],
    'cobertura_medicamentos' => @request['cobertura'],
    'limite_cobertura_visitas' => @request['limite_cobertura_visitas'],
    'copago' => @request['copago'],
    'cantidad_hijos_maxima' => cantidad_hijos_maxima,
    'edad_minima' => edad_minima,
    'edad_maxima' => edad_maxima
  }
end

Entonces('se obtiene un error de plan sin nombre') do
  expect(@response.status).to eq 400
end

Entonces('se obtiene un error de plan sin costo') do
  expect(@response.status).to eq 400
end

Entonces('se obtiene un error de plan sin rango de edades') do
  expect(@response.status).to eq 400
end

Entonces('se obtiene un error de plan sin valor de copago') do
  expect(@response.status).to eq 400
end

Entonces('se obtiene un error de plan sin cantidad de hijos') do
  expect(@response.status).to eq 400
end

Entonces('se obtiene un error de plan sin estado civil') do
  expect(@response.status).to eq 400
end

Entonces('se obtiene un error de plan sin cobertura de medicamentos') do
  expect(@response.status).to eq 400
end

Entonces('se obtiene un error de plan con rango de edades invalido') do
  expect(@response.status).to eq 400
end
