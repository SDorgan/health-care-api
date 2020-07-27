class PlanResponseBuilder
  def self.create_from(plan)
    {
      'plan': {
        'id': plan.id,
        'nombre': plan.nombre,
        'costo': plan.costo,
        'limite_cobertura_visitas': plan.cobertura_visitas.cantidad,
        'copago': plan.cobertura_visitas.copago,
        'cobertura_medicamentos': plan.cobertura_medicamentos.porcentaje,
        'edad_minima': plan.edad_minima,
        'edad_maxima': plan.edad_maxima
      }
    }.to_json
  end

  def self.create_from_all(planes) # rubocop:disable Metrics/AbcSize
    output = { 'planes': [] }

    planes.each do |plan|
      output[:planes] << {
        'id': plan.id,
        'nombre': plan.nombre,
        'costo': plan.costo,
        'limite_cobertura_visitas': plan.cobertura_visitas.cantidad,
        'copago': plan.cobertura_visitas.copago,
        'cobertura_medicamentos': plan.cobertura_medicamentos.porcentaje,
        'edad_minima': plan.edad_minima,
        'edad_maxima': plan.edad_maxima
      }
    end

    output.to_json
  end
end
