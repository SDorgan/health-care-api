class CovidService
  def initialize(repo_afiliados)
    @repo_afiliados = repo_afiliados
  end

  def registrar(id)
    afiliado = @repo_afiliados.find_by_telegram_id(id)
    afiliado.covid_sospechoso = true

    @repo_afiliados.save(afiliado)
  end
end
