class CentroService
  def initialize(repo_centro)
    @repo_centro = repo_centro
  end

  def buscar(params = {})
    nombre_prestacion = params[:nombre_prestacion]

    centros = if nombre_prestacion.nil?
                CentroRepository.new.all
              else
                CentroRepository.new.find_by_prestacion(nombre_prestacion)
              end

    centros
  end

  def registrar(nombre, latitud, longitud)
    centro = Centro.new(nombre, latitud, longitud)

    existe = @repo_centro.exists_by_name(nombre)

    raise CentroYaExistenteError if existe

    existe = @repo_centro.exists_by_coordinates(latitud, longitud)

    raise CentroYaExistenteError if existe

    @repo_centro.save(centro)
  end
end
