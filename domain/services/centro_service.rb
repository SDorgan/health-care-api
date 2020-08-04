require_relative '../../app/errors/prestacion_no_encontrada'

class CentroService
  def initialize(repo_centro, repo_prestaciones, calculador_distancia)
    @repo_centro = repo_centro
    @repo_prestaciones = repo_prestaciones
    @calculador_distancia = calculador_distancia
  end

  def buscar(params = {})
    nombre_prestacion = params[:nombre_prestacion]
    latitud = params[:latitud]
    longitud = params[:longitud]

    return @repo_centro.find_by_prestacion(nombre_prestacion) unless nombre_prestacion.nil?

    return find_nearest_to(latitud, longitud) unless latitud.nil? || longitud.nil?

    @repo_centro.all
  rescue PrestacionNoEncontrada
    raise PrestacionInexistenteError
  end

  def add_prestacion(centro_id, nombre_prestacion)
    centro = @repo_centro.find(centro_id)
    prestacion = @repo_prestaciones.find(nombre_prestacion)

    @repo_centro.add_prestacion(centro, prestacion)
  rescue PrestacionNoEncontrada
    raise PrestacionInexistenteError
  rescue CentroNoEncontrado
    raise CentroInexistenteError
  end

  def registrar(nombre, latitud, longitud)
    centro = Centro.new(nombre, latitud, longitud)

    existe = @repo_centro.exists_by_name(nombre)

    raise CentroYaExistenteError if existe

    existe = @repo_centro.exists_by_coordinates(latitud, longitud)

    raise CentroYaExistenteError if existe

    @repo_centro.save(centro)
  end

  private

  def find_nearest_to(latitud, longitud)
    centros = @repo_centro.all

    return centros if centros.empty?

    resultado = @calculador_distancia.obtener_direcciones_a_punto(centros, latitud, longitud)

    distancias = resultado[:distancias]
    direcciones = resultado[:direcciones]

    indice_menor_distancia = distancias.rindex(distancias.min)

    centro = centros[indice_menor_distancia]
    centro.distancia = distancias[indice_menor_distancia]
    centro.direccion = direcciones[indice_menor_distancia]

    [centro]
  end
end
