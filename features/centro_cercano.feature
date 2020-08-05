# language: es

Característica: Centros Cercanos
  Para que los afiliados puedan saber mejor dónde atenderse
  Como administrador de la prepaga
  Quiero poder buscar el centro más cercano a mi ubicación

  @wip
  Escenario: CCC1 - Consulta por cercanía cuando hay dos centros devuelve el más cercano
    Dado el centro con nombre "Hospital Aleman"
    Y coordenadas geográficas latitud "-34.591874" y longitud "-58.101343"
    Y se registra el centro
    Y el centro con nombre "Hospital Pirovano"
    Y coordenadas geográficas latitud "-33.564954" y longitud "-58.470786"
    Y se registra el centro
    Cuando consulto por centros cercanos a latitud "-34.117793" y longitud "-58.968414"
    Entonces el centro más cercano es el "Hospital Alemán"

  Escenario: CCC2 - Consulta por cercanía cuando no hay centros
    Cuando consulto por centros cercanos a latitud "-34.117793" y longitud "-58.968414"
    Entonces se obtiene una respuesta vacía

  @wip
  Escenario: CCC3 - Consulta por cercanía cuando hay cuatro centros devuelve el más cercano
    Dado el centro con nombre "Hospital Aleman"
    Y coordenadas geográficas latitud "-34.591874" y longitud "-58.101343"
    Y se registra el centro
    Y el centro con nombre "Hospital Pirovano"
    Y coordenadas geográficas latitud "-33.564954" y longitud "-58.470786"
    Y se registra el centro
    Y el centro con nombre "Hospital Garrahan"
    Y coordenadas geográficas latitud "-33.964954" y longitud "-59.393617"
    Y se registra el centro
    Y el centro con nombre "Hospital Córdoba"
    Y coordenadas geográficas latitud "-31.406235" y longitud "-64.158172"
    Y se registra el centro
    Cuando consulto por centros cercanos a latitud "-34.117793" y longitud "-58.968414"
    Entonces el centro más cercano es el "Hospital Garrahan"
