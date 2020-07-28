class AfiliadoResponseBuilder
  def self.create_from_all(afiliados)
    output = { 'afiliados': [] }

    afiliados.each do |afiliado|
      output[:afiliados] << {
        'id': afiliado.id,
        'nombre': afiliado.nombre,
        'id_telegram': afiliado.id_telegram,
        'plan_id': afiliado.plan.id
      }
    end

    output.to_json
  end

  def self.create_from(afiliado)
    {
      'id': afiliado.id
    }.to_json
  end
end
