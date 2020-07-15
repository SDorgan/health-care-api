class Afiliado
  attr_accessor :id, :nombre, :id_telegram, :id_plan

  def initialize(nombre, id_plan)
    @nombre = nombre
    @id_plan = id_plan
  end
end
