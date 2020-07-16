class Resumen
  attr_accessor :afiliado, :plan
  def initialize(afiliado, plan, visitas)
    @afiliado = afiliado
    @plan = plan
    @visitas = visitas
  end

  def costo_adicional
    @visitas.map { |visita| visita.prestacion.costo }.inject(0, :+)
  end

  def total
    @plan.costo + costo_adicional
  end
end
