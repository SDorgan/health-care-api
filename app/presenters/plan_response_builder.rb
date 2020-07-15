class PlanResponseBuilder
  def self.create_from(plan)
    {
      'plan': {
        'id': plan.id,
        'nombre': plan.nombre,
        'costo': plan.costo
      }
    }.to_json
  end

  def self.create_from_all(planes)
    output = { 'planes': [] }

    planes.each do |plan|
      output[:planes] << {
        'id': plan.id,
        'nombre': plan.nombre,
        'costo': plan.costo
      }
    end

    output.to_json
  end
end
