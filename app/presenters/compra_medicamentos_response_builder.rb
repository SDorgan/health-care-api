class CompraMedicamentosResponseBuilder
  def self.create_from(compra)
    {
      'compra': {
        'id': compra.id,
        'afiliado': compra.afiliado_id,
        'monto': compra.monto,
        'fecha_compra': compra.fecha_compra
      }
    }.to_json
  end
end
