class AfiliadoResponseBuilder
  def self.create_from_all(afiliados)
    output = { 'afiliados': [] }

    afiliados.each do |afiliado|
      output[:afiliados] << {
        'id': afiliado.id,
        'nombre': afiliado.nombre,
        'id_telegram': afiliado.id_telegram,
        'id_plan': afiliado.id_plan
      }
    end

    output.to_json
  end
end
