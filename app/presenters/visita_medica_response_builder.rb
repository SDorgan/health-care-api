class VisitaMedicaResponseBuilder
  def self.create_from(visita_medica)
    {
      'visita': {
        'id': visita_medica.id,
        'afiliado': visita_medica.afiliado_id,
        'prestacion': visita_medica.prestacion.nombre,
        'created_on': visita_medica.created_on
      }
    }.to_json
  end
end
