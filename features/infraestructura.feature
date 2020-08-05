# language: es

Característica: Infraestructura
  Para poder probar la API
  Como administrador
  Quiero poder manejar los datos en las bases

  Antecedentes:
    Dado que existe un plan
    Y que existe una prestacion
    Y que existe un centro
  @wip
  @mvp
  Escenario: INFRA1 - Seguridad: los requests sin api-key deben ser rechazados
    Dado el afiliado "pepeinseguro"
    Cuando se registra pero no envia api-key
    Entonces obtiene error 403

  Escenario: INFRA3.1 - Endpoint de /reset elimina los datos
    Cuando se ejecuta POST /reset
    Entonces se eliminan los datos

  Escenario: INFRA3.2 - Endpoint de /reset no está disponible en el ambiente de producción
    Dado que se esta en el ambiente de producción
    Cuando se ejecuta POST /reset
    Entonces se obtiene un error

  Escenario: INFRA2 - Trazabilidad de arfactos: el endpoint /version no requiere api-key
    Cuando se ejecuta GET /version
    Entonces obtiene una version semántica de 3 números
