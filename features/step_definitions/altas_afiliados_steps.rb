Dado('el afiliado {string} de {int} años, conyuge {string}, hijos {int}') do |nombre, edad, conyuge, hijos| # rubocop:disable LineLength
  conyuge = if conyuge.eql? 'si'
              true
            else
              false
            end
  @request = {
    'nombre' => nombre,
    'cantidad_hijos' => hijos,
    'edad' => edad,
    'conyuge' => conyuge
  }
end

Dado('el usuario {string} que no esta afiliado') do |_string|
  @id_afiliado = 9_999_999
end

Cuando('se registra al plan {string}') do |plan|
  @request = {
    'nombre' => @request['nombre'],
    'nombre_plan' => plan,
    'cantidad_hijos' => @request['cantidad_hijos'],
    'edad' => @request['edad'],
    'conyuge' => @request['conyuge']
  }
  @response_afiliado = Faraday.post(AFILIADOS_URL, @request.to_json, 'Content-Type' => 'application/json', 'HTTP_API_KEY' => API_KEY)
end

Entonces('obtiene un numero unico de afiliado') do
  json_response = JSON.parse(@response_afiliado.body)

  id = json_response['id']
  expect(@response.status).to eq 201
  expect(id).not_to be_nil
end

Entonces('obtiene un mensaje de error por plan inexistente') do
  expect(@response_afiliado.status).to eq 400
  expect(@response_afiliado.body).to eq 'El plan es inexistente'
end

Entonces('obtiene un mensaje de error supera limite de edad') do
  expect(@response_afiliado.status).to eq 400
  expect(@response_afiliado.body).to eq 'supera el límite máximo de edad'
end

Entonces('obtiene un mensaje de error no alcanza el limite minimo de edad') do
  expect(@response_afiliado.status).to eq 400
  expect(@response_afiliado.body).to eq 'no alcanza el límite mínimo de edad'
end

Entonces('obtiene un mensaje de error por tener conyuge') do
  expect(@response_afiliado.status).to eq 400
  expect(@response_afiliado.body).to eq 'este plan no admite conyuge'
end

Entonces('obtiene un mensaje de error por tener hijos') do
  expect(@response_afiliado.status).to eq 400
  expect(@response_afiliado.body).to eq 'este plan no admite hijos'
end

Entonces('obtiene un mensaje de error por superar la cantidad de hijos maxima') do
  expect(@response_afiliado.status).to eq 400
  expect(@response_afiliado.body).to eq 'supera la cantidad de hijos requeridos para el plan'
end

Entonces('obtiene un mensaje de error porque requiere hijos') do
  expect(@response_afiliado.status).to eq 400
  expect(@response_afiliado.body).to eq 'este plan requiere tener hijos'
end
