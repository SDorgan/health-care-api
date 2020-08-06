class VisitaMedicaResponseBuilder
  def self.create_from(visita_medica)
    {
      'visita': {
        'id': visita_medica.id,
        'afiliado': visita_medica.afiliado_id,
        'prestacion': visita_medica.prestacion.nombre,
        'fecha_visita': visita_medica.fecha_visita
      }
    }.to_json
  end
end
