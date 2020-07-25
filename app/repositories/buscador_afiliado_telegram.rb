class BuscadorAfiliadoTelegram
  def initialize(repo)
    @repo = repo
  end

  def find(id_telegram)
    @repo.find_by_telegram_id(id_telegram)
  end
end
