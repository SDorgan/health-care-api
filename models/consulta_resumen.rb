class ConsultaResumen
  def initialize(repo_afiliados, repo_planes, repo_visitas)
    @repo_afiliados = repo_afiliados
    @repo_planes = repo_planes
    @repo_visitas = repo_visitas
  end

  def generar_resumen(afiliado_id)
    afiliado = @repo_afiliados.find(afiliado_id)

    plan = @repo_planes.find(afiliado.plan_id)

    visitas = @repo_visitas.find_by_afiliado(afiliado.id)

    Resumen.new(afiliado, plan, visitas)
  end
end
