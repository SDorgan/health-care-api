class PlanResponseBuilder
  def self.create_from(plan)
    {
      'plan': {
        'id': plan.id,
        'nombre': plan.nombre,
        'costo': plan.costo,
        'limite_cobertura_visitas': plan.limite_cobertura_visitas,
        'copago': plan.copago,
        'cobertura_medicamentos': plan.cobertura_medicamentos
      }
    }.to_json
  end

  def self.create_from_all(planes)
    output = { 'planes': [] }

    planes.each do |plan|
      output[:planes] << {
        'id': plan.id,
        'nombre': plan.nombre,
        'costo': plan.costo,
        'limite_cobertura_visitas': plan.limite_cobertura_visitas,
        'copago': plan.copago,
        'cobertura_medicamentos': plan.cobertura_medicamentos
      }
    end

    output.to_json
  end
end
