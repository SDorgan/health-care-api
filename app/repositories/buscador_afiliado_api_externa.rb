class BuscadorAfiliadoApiExterna
  def initialize(repo)
    @repo = repo
  end

  def find(id)
    @repo.find(id.to_i)
  end

  def exists_afiliado_with_id(id)
    @repo.exists_afiliado_with_id(id)
  end
end
