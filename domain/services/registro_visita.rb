require_relative '../../app/errors/id_not_afiliado_error'
require_relative '../../app/errors/prestacion_not_exists_error'
require_relative '../../app/errors/centro_inexistente_error'
require_relative '../../app/errors/centro_no_contiene_prestacion_error'

class RegistroVisita
  def initialize(repo_afiliados, repo_prestaciones, repo_centros, repo_visitas)
    @repo_afiliados = repo_afiliados
    @repo_prestaciones = repo_prestaciones
    @repo_centros = repo_centros
    @repo_visitas = repo_visitas
  end

  def registrar(afiliado_id, prestacion_id, centro_id)
    raise IdNotAfiliadoError unless @repo_afiliados.exists_afiliado_with_id(afiliado_id)

    prestacion = @repo_prestaciones.find(prestacion_id)

    centro = @repo_centros.find(centro_id)

    raise CentroNoContienePrestacionError unless @repo_centros.centro_contains_prestacion(centro, prestacion) # rubocop:disable Metrics/LineLength

    visita_medica = VisitaMedica.new(afiliado_id, prestacion, centro)

    @repo_visitas.save(visita_medica)
  end
end
