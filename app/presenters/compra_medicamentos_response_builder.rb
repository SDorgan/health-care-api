class CompraMedicamentosResponseBuilder
  def self.create_from(compra)
    {
      'compra': {
        'id': compra.id,
        'afiliado': compra.afiliado_id,
        'monto': compra.monto,
        'created_on': compra.created_on
      }
    }.to_json
  end
end
