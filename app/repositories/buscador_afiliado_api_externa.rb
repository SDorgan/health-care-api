class BuscadorAfiliadoApiExterna
  def initialize(repo)
    @repo = repo
  end

  def find(id)
    @repo.find(id.to_i)
  end
end
