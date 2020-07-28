class Afiliado
  attr_accessor :id, :nombre, :id_telegram, :plan, :covid_sospechoso

  def initialize(nombre, plan)
    @covid_sospechoso = false
    @nombre = nombre
    @plan = plan
  end
end
