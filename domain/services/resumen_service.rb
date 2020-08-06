require_relative '../../app/errors/afiliado_no_encontrado'

class ResumenService
  def initialize(repo_afiliados, repo_visitas, repo_compras)
    @repo_afiliados = repo_afiliados
    @repo_visitas = repo_visitas
    @repo_compras = repo_compras
  end

  def generar(id)
    afiliado = @repo_afiliados.find_by_telegram_id(id)

    resumen = Resumen.new(afiliado,
                          @repo_visitas,
                          @repo_compras)

    resumen.generar

    resumen
  rescue AfiliadoNoEncontrado
    raise UsuarioNoAfiliadoError
  end
end
