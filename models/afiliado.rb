class Afiliado
  attr_accessor :id, :nombre, :id_telegram, :plan_id, :covid_sospechoso

  def initialize(nombre, plan_id)
    @covid_sospechoso = false
    @nombre = nombre
    @plan_id = plan_id
  end
end
