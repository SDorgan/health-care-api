class CentroService
  def initialize(repo_centro, calculador_distancia)
    @repo_centro = repo_centro
    @calculador_distancia = calculador_distancia
  end

  def buscar(params = {})
    nombre_prestacion = params[:nombre_prestacion]
    latitud = params[:latitud]
    longitud = params[:longitud]

    return @repo_centro.find_by_prestacion(nombre_prestacion) unless nombre_prestacion.nil?

    return find_nearest_to(latitud, longitud) unless latitud.nil? || longitud.nil?

    @repo_centro.all
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

  def find_nearest_to(_latitud, _longitud)
    []
  end
end
