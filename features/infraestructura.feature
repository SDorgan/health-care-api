   # language: es

Característica: Infraestructura
  Para poder probar la API
  Como administrador
  Quiero poder manejar los datos en las bases

  Antecedentes:
    Dado que existe un plan
    Y que existe una prestacion

  @mvp
  Escenario: INFRA3.1 - Endpoint de /reset elimina los datos
    Cuando se ejecuta POST /reset
    Entonces se eliminan los datos

  Escenario: INFRA3.2 - Endpoint de /reset no está disponible en el ambiente de producción
    Dado que se esta en el ambiente de producción
    Cuando se ejecuta POST /reset
    Entonces se obtiene un error
