# language: es

Característica: CRUD Centros
  Para poder obtener afiliados
  Como administrador de la prepaga
  Quiero poder manejar los centros medicos

  @mvp
  Escenario: ACEN1 - Alta exitosa de centro con coordenadas
    Dado el centro con nombre "Hospital Alemán"
    Y coordenadas geográficas latitud "-34.617670" y longitud "-58.368360"
    Cuando se registra el centro
    Entonces se registra exitosamente

  @mvp
  Escenario: ACEN2 - Alta fallida de centro
    Dado el centro con nombre "Hospital Alemán"
    Cuando se registra el centro
    Entonces se obtiene un mensaje de error por falta de coordenadas

  @mvp
  Escenario: ACEN3 - Alta fallida por centro ya existente
    Dado el centro con nombre "Hospital Alemán"
    Y coordenadas geográficas latitud "-34.617670" y longitud "-58.368360"
    Y se registra el centro
    Cuando el centro con nombre "Hospital Alemán"
    Y coordenadas geográficas latitud "-34.617670" y longitud "-58.368360"
    Y se registra el centro
    Entonces se obtiene un mensaje de error centro ya existente

  @mvp
  Escenario: ACEN4 - Alta fallida por nombre de centro repetido
    Dado el centro con nombre "Hospital Alemán"
    Y coordenadas geográficas latitud "-34.617670" y longitud "-58.368360"
    Y se registra el centro
    Y el centro con nombre "hospital aleman"
    Y coordenadas geográficas latitud "-39.617670" y longitud "-54.368360"
    Cuando se registra el centro
    Entonces se obtiene un mensaje de error centro ya existente

  @mvp
  Escenario: ACEN5 - Alta fallida por colision de coodeandas
    Dado el centro con nombre "Hospital Alemán"
    Y coordenadas geográficas latitud "-34.617670" y longitud "-58.368360"
    Y se registra el centro
    Y el centro con nombre "Hospital Sirio"
    Y coordenadas geográficas latitud "-34.111111" y longitud "-58.222222"
    Cuando se registra el centro
    Entonces se obtiene un mensaje de error centro ya existente
