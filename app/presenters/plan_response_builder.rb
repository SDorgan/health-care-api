class PlanResponseBuilder
  def self.create_from(plan)
    {
      'plan': {
        'id': plan.id,
        'nombre': plan.nombre,
        'precio': plan.precio
      }
    }.to_json
  end

  def self.create_from_all(planes)
    output = { 'planes': [] }

    planes.each do |plan|
      output[:planes] << {
        'id': plan.id,
        'nombre': plan.nombre,
        'precio': plan.precio
      }
    end

    output.to_json
  end
end
