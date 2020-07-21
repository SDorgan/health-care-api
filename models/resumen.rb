class Resumen
  attr_accessor :afiliado, :plan

  def initialize(afiliado, repo_planes, repo_visitas)
    @afiliado = afiliado
    @repo_planes = repo_planes
    @repo_visitas = repo_visitas
  end

  def generar
    @plan = @repo_planes.find(@afiliado.plan_id)

    @visitas = @repo_visitas.find_by_afiliado(@afiliado.id)
  end

  def costo_adicional
    visitas_filtradas = @plan.cobertura_visitas.filtrar(@visitas)

    visitas_filtradas.map { |visita| visita.prestacion.costo }.inject(0, :+)
  end

  def total
    @plan.costo + costo_adicional
  end
end
