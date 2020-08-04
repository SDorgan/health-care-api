class CentroService
  def initialize(repo_centro)
    @repo_centro = repo_centro
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
