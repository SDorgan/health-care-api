class Afiliado
  attr_accessor :id, :nombre, :id_telegram, :plan_id

  def initialize(nombre, plan_id)
    @nombre = nombre
    @plan_id = plan_id
  end
end
