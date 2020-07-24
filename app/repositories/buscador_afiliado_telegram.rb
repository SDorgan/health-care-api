class BuscadorAfiliadoTelegram
  def initialize(repo)
    @repo = repo
  end

  def find(id_telegram)
    @repo.find_by_telegram_id(id_telegram)
  end

  def exists_afiliado_with_id(tele_id)
    @repo.exists_afiliado_with_telegram_id(tele_id)
  end
end
