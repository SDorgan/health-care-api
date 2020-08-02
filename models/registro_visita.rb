class RegistroVisita

  def initialize(repo_afiliados, repo_prestaciones, repo_centros, repo_visitas)
    @repo_afiliados = repo_afiliados
    @repo_prestaciones = repo_prestaciones
    @repo_centros = repo_centros
    @repo_visitas = repo_visitas
  end

  def registrar(afiliado_id, prestacion_id, centro_id)
    raise IdNotAfiliadoError unless AfiliadoRepository.new.exists_afiliado_with_id(afiliado_id)

    prestacion = PrestacionRepository.new.find(params['prestacion'])

    centro = CentroRepository.new.find(params['centro'])

    raise CentroNoContienePrestacionError unless CentroRepository.new.centro_contains_prestacion(centro, prestacion) # rubocop:disable Metrics/LineLength

    visita_medica = VisitaMedica.new(afiliado_id, prestacion, centro)

    visita_medica = VisitaMedicaRepository.new.save(visita_medica)
  end
end
