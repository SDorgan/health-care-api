class Registro
  def initialize(repo_afiliados, repo_planes)
    @repo_afiliados = repo_afiliados
    @repo_planes = repo_planes
  end

  def registrar_afiliado(data = {})
    plan = @repo_planes.find_by_name(data[:nombre_plan].to_s)
    afiliado = Afiliado.new(data[:nombre_afiliado], plan.id)
    afiliado.id_telegram = data[:id_telegram] unless data[:id_telegram].nil?
    @repo_afiliados.save(afiliado)
  end
end
