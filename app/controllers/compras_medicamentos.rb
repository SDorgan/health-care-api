HealthAPI::App.controllers :medicamentos do
  post :index do
    params = JSON.parse(request.body.read)

    afiliado_id = params['afiliado']

    monto = params['monto']

    compra = CompraMedicamentos.new(afiliado_id, monto)

    compra = CompraMedicamentosRepository.new.save(compra)

    status 201

    CompraMedicamentosResponseBuilder.create_from(compra)
  end
end
