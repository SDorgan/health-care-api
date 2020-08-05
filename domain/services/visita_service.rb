require_relative '../../app/errors/afiliado_no_encontrado'
require_relative '../../app/errors/centro_no_encontrado'
require_relative '../../app/errors/prestacion_no_encontrada'

class VisitaService
  def initialize(repo_afiliados, repo_prestaciones, repo_centros, repo_visitas)
    @repo_afiliados = repo_afiliados
    @repo_prestaciones = repo_prestaciones
    @repo_centros = repo_centros
    @repo_visitas = repo_visitas
  end

  def registrar(afiliado_id, prestacion_id, centro_id)
    afiliado = @repo_afiliados.find(afiliado_id)

    prestacion = @repo_prestaciones.find(prestacion_id)

    centro = @repo_centros.find(centro_id)

    raise CentroNoContienePrestacionError unless @repo_centros.contains_prestacion(centro,
                                                                                   prestacion)

    visita_medica = VisitaMedica.new(afiliado.id, prestacion, centro)

    @repo_visitas.save(visita_medica)
  rescue AfiliadoNoEncontrado
    raise UsuarioNoAfiliadoError
  rescue CentroNoEncontrado
    raise CentroInexistenteError
  rescue PrestacionNoEncontrada
    raise PrestacionInexistenteError
  end
end
