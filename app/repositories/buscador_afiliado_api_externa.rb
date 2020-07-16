class BuscadorAfiliadoApiExterna
  def initialize(repo)
    @repo = repo
  end

  def find(id)
    @repo.find(id)
  end
end
