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

  @mvp
  Escenario: APLA1.1 - Alta exitosa de PlanJuventud con nombre y precio
    Dado el plan con nombre "PlanJuventud" con costo unitario $500
    Cuando se registra el plan
    Entonces se registra exitosamente

  @mvp
    Escenario: APLA1.2 - Alta exitosa de plan310 con nombre, precio y limite de visitas
        Dado el plan con nombre "Plan310" con costo unitario $1000
        Y cobertura de visitas con límite 4
        Cuando se registra el plan
        Entonces se registra exitosamente

    Escenario: APLA1.3 - Alta exitosa de plan310 con nombre, precio y limite de visitas infinito
        Dado el plan con nombre "Plan310" con costo unitario $1000
        Y cobertura de visitas con límite infinito
        Cuando se registra el plan
        Entonces se registra exitosamente

  @mvp
    Escenario: APLA1.4 - Alta exitosa de plan 310 con nombre, precio, limite de vistas y copago
        Dado el plan con nombre "Plan310" con costo unitario $1000
        Y cobertura de visitas con copago $100 y con límite 4
        Cuando se registra el plan
        Entonces se registra exitosamente


