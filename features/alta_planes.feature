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

  Escenario: APLA1 - Alta exitosa de PlanJuventud
    Dado el plan con nombre "PlanJuventud" con costo unitario $500
    Y restricciones edad min 15, edad max 20, hijos max 0, admite conyuge "no"
    Y cobertura de visitas con copago $0 y con límite 2
    Y cobertura de medicamentos 20%
    Cuando se registra el plan
    Entonces se registra exitosamente

  Escenario: APLA1.1 - Alta exitosa de PlanJuventud con nombre y precio
    Dado el plan con nombre "PlanJuventud" con costo unitario $500
    Cuando se registra el plan
    Entonces se registra exitosamente

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

  Escenario: APLA1.4 - Alta exitosa de plan 310 con nombre, precio, limite de vistas y copago
    Dado el plan con nombre "Plan310" con costo unitario $1000
    Y cobertura de visitas con copago $100 y con límite 4
    Cuando se registra el plan
    Entonces se registra exitosamente

  Escenario: APLA1.5 - Alta exitosa de plan 310 con nombre, precio, limite de vistas y copago y cobertura de medicamentos
    Dado el plan con nombre "Plan310" con costo unitario $1000
    Y cobertura de visitas con copago $100 y con límite 4
    Y cobertura de medicamentos 30%
    Cuando se registra el plan
    Entonces se registra exitosamente

  @wip
  Escenario: APLA1.6 - Nombre no especificado
    Dado el plan con costo unitario $500
    Y restricciones edad min 15, edad max 20, hijos max 0, conyuge "no"
    Y cobertura de visitas con copago $0 y con límite 2
    Y cobertura de medicamentos 20%
    Cuando se registra el plan
    Entonces se obtiene un error

  @wip
  Escenario: APLA1.7 - Costo no especificado
    Dado el plan con nombre "PlanJuventud"
    Y restricciones edad min 15, edad max 20, hijos max 0, conyuge "no"
    Y cobertura de visitas con copago $0 y con límite 2
    Y cobertura de medicamentos 20%
    Cuando se registra el plan
    Entonces se obtiene un error

  @wip
  Escenario: APLA1.8 - Rango de edades no especificado
    Dado el plan con nombre "PlanJuventud" con costo unitario $500
    Y restricciones hijos max 0, conyuge "no"
    Y cobertura de visitas con copago $0 y con límite 2
    Y cobertura de medicamentos 20%
    Cuando se registra el plan
    Entonces se obtiene un error

  @wip
  Escenario: APLA1.9 - Precio del copago no especificado
    Dado el plan con nombre "PlanJuventud" con costo unitario $500
    Y restricciones edad min 15, edad max 20, hijos max 0, conyuge "no"
    Y cobertura de visitas con límite 2
    Y cobertura de medicamentos 20%
    Cuando se registra el plan
    Entonces se obtiene un error

  Escenario: APLA2 - Alta exitosa de plan 310
    Dado el plan con nombre "Plan310" con costo unitario $1000
    Y restricciones edad min 21, edad max 99, hijos max 0, admite conyuge "no"
    Y cobertura de visitas con copago $100 y con límite 4
    Y cobertura de medicamentos 30%
    Cuando se registra el plan
    Entonces se registra exitosamente

  Escenario: APLA3 - Alta exitosa de plan familiar
    Dado el plan con nombre "PlanFamiliar" con costo unitario $2000
    Y restricciones edad min 15, edad max 99, hijos max 6, admite conyuge "si"
    Y cobertura de visitas con copago $50 y con límite infinito
    Y cobertura de medicamentos 50%
    Cuando se registra el plan
    Entonces se registra exitosamente

  Escenario: APLA4 - Alta exitosa de plan pareja
    Dado el plan con nombre "PlanPareja" con costo unitario $1700
    Y restricciones edad min 20, edad max 99, hijos max 0, requiere conyuge "si"
    Y cobertura de visitas con copago $250 y con límite infinito
    Y cobertura de medicamentos 10%
    Cuando se registra el plan
    Entonces se registra exitosamente
