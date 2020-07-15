# language: es

Característica: CRUD Planes
  Para poder obtener afiliados
  Como administrador de la prepaga
  Quiero poder manejar los planes

  Escenario: Crear un nuevo plan
    Dado el plan con nombre "Neo"
    Cuando consulto los planes disponibles
    Entonces obtengo el plan con nombre "Neo"

  Escenario: Crear varios planes
    Dado el plan con nombre "Neo"
    Dado el plan con nombre "Familiar"
    Cuando consulto los planes disponibles
    Entonces obtengo el plan con nombre "Neo"
    Y obtengo el plan con nombre "Familiar"

  @wip
  @mvp
  Escenario: APLA1.1 - Alta exitosa de PlanJuventud con nombre y precio
    Dado el plan con nombre "PlanJuventud" con costo unitario $500
    Cuando se registra el plan
    Entonces se registra exitosamente

