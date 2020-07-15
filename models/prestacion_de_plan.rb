class PrestacionDePlan
  attr_accessor :id, :plan_id, :prestacion_id

  def initialize(plan, prestacion)
    @plan_id = plan.id
    @prestacion_id = prestacion.id
  end
end
