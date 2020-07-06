# language: es

Característica: CRUD Planes
  Para poder obtener afiliados
  Como administrador de la prepaga
  Quiero poder manejar los planes

  @wip
  Escenario: Crear un nuevo plan
    Dado el plan con nombre "Neo"
    Cuando consulto los planes disponibles
    Entonces obtengo el plan con nombre "Neo"

  @wip
  Escenario: Crear varios planes
    Dado el plan con nombre "Neo"
    Dado el plan con nombre "Familiar"
    Cuando consulto los planes disponibles
    Entonces obtengo el plan con nombre "Neo"
    Y obtengo el plan con nombre "Familiar"
