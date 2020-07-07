class PlanResponseBuilder
  def self.create_from(plan)
    {
      'plan': {
        'id': plan.id,
        'nombre': plan.nombre
      }
    }
  end

  def self.create_from_all(planes)
    output = { 'planes': [] }

    planes.each do |plan|
      output[:planes] << {
        'id': plan.id,
        'nombre': plan.nombre
      }
    end

    output
  end
end
