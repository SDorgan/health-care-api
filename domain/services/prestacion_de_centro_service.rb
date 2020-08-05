require_relative '../../app/errors/prestacion_no_encontrada'
require_relative '../../app/errors/centro_no_encontrado'

class PrestacionDeCentroService
  def initialize(repo_centros, repo_prestaciones)
    @repo_centros = repo_centros
    @repo_prestaciones = repo_prestaciones
  end

  def registrar(centro_id, prestacion_id)
    centro = @repo_centros.find(centro_id)
    prestacion = @repo_prestaciones.find(prestacion_id)

    raise CentroYaContienePrestacionError if @repo_centros.contains_prestacion(centro, prestacion)

    @repo_centros.add_prestacion(centro, prestacion)
  rescue PrestacionNoEncontrada
    raise PrestacionInexistenteError
  rescue CentroNoEncontrado
    raise CentroInexistenteError
  end
end
