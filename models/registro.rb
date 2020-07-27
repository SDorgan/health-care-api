class Registro
  def initialize(repo_afiliados, repo_planes)
    @repo_afiliados = repo_afiliados
    @repo_planes = repo_planes
  end

  def registrar_afiliado(nombre_afiliado, nombre_plan, id_telegram, _edad, _conyuge)
    plan = @repo_planes.find_by_name(nombre_plan.to_s)
    afiliado = Afiliado.new(nombre_afiliado, plan.id)
    afiliado.id_telegram = id_telegram unless id_telegram.nil?
    @repo_afiliados.save(afiliado)
  end
end
