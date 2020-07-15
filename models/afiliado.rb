class Afiliado
  attr_accessor :id, :nombre, :id_telegram, :id_plan

  def initialize(nombre, id_telegram, id_plan)
    @nombre = nombre
    @id_telegram = id_telegram
    @id_plan = id_plan
  end
end
