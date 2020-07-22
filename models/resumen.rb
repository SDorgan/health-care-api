class Resumen
  attr_accessor :afiliado, :plan

  def initialize(afiliado, repo_planes, repo_visitas, repo_medicamentos)
    @afiliado = afiliado
    @repo_planes = repo_planes
    @repo_visitas = repo_visitas
    @repo_medicamentos = repo_medicamentos
  end

  def generar
    @plan = @repo_planes.find(@afiliado.plan_id)

    @visitas = @repo_visitas.find_by_afiliado(@afiliado.id)
    @compras_medicamentos = @repo_medicamentos.find_by_afiliado(@afiliado.id)
  end

  def costo_adicional
    adicional_visitas + adicional_medicamentos
  end

  def total
    @plan.costo + costo_adicional
  end

  private

  def adicional_visitas
    @visitas = @plan.cobertura_visitas.aplicar(@visitas)

    @visitas.map(&:costo).inject(0, :+)
  end

  def adicional_medicamentos
    @compras_medicamentos = @plan.cobertura_medicamentos.aplicar(@compras_medicamentos)
    @compras_medicamentos.map(&:costo_final).inject(0, :+)
  end
end
