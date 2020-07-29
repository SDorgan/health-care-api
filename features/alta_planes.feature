# language: es

Característica: CRUD Planes
  Para poder obtener afiliados
  Como administrador de la prepaga
  Quiero poder manejar los planes

  Escenario: APLA1 - Alta exitosa de PlanJuventud
    Dado el plan con nombre "PlanJuventud" con costo unitario $500
    Y restricciones edad min 15, edad max 20, hijos max 0, admite conyuge "no"
    Y cobertura de visitas con copago $0 y con límite 2
    Y cobertura de medicamentos 20%
    Cuando se registra el plan
    Entonces se registra exitosamente

  Escenario: APLA1.6 - Nombre no especificado
    Dado el plan con costo unitario $500
    Y restricciones edad min 15, edad max 20, hijos max 0, admite conyuge "no"
    Y cobertura de visitas con copago $0 y con límite 2
    Y cobertura de medicamentos 20%
    Cuando se registra el plan invalido
    Entonces se obtiene un error de plan sin nombre

  Escenario: APLA1.7 - Costo no especificado
    Dado el plan con nombre "PlanJuventud"
    Y restricciones edad min 15, edad max 20, hijos max 0, admite conyuge "no"
    Y cobertura de visitas con copago $0 y con límite 2
    Y cobertura de medicamentos 20%
    Cuando se registra el plan invalido
    Entonces se obtiene un error de plan sin costo

  Escenario: APLA1.8 - Rango de edades no especificado
    Dado el plan con nombre "PlanJuventud" con costo unitario $500
    Y restricciones hijos max 0, admite conyuge "no"
    Y cobertura de visitas con copago $0 y con límite 2
    Y cobertura de medicamentos 20%
    Cuando se registra el plan invalido
    Entonces se obtiene un error de plan sin rango de edades

  Escenario: APLA1.9 - Precio del copago no especificado
    Dado el plan con nombre "PlanJuventud" con costo unitario $500
    Y cobertura de visitas con límite 2
    Y cobertura de medicamentos 20%
    Y restricciones edad min 15, edad max 20, hijos max 0, admite conyuge "no"
    Cuando se registra el plan invalido
    Entonces se obtiene un error de plan sin valor de copago

  Escenario: APLA1.10 - Cantidad de hijos no especificado
    Dado el plan con nombre "PlanJuventud" con costo unitario $500
    Y restricciones edad min 15, edad max 20, admite conyuge "no"
    Y cobertura de visitas con copago $0 y con límite 2
    Y cobertura de medicamentos 20%
    Cuando se registra el plan invalido
    Entonces se obtiene un error de plan sin cantidad de hijos

  Escenario: APLA1.11 - Estado civil no especificado
    Dado el plan con nombre "PlanJuventud" con costo unitario $500
    Y restricciones edad min 15, edad max 20, hijos max 0
    Y cobertura de visitas con copago $0 y con límite 2
    Y cobertura de medicamentos 20%
    Cuando se registra el plan invalido
    Entonces se obtiene un error de plan sin estado civil

  Escenario: APLA1.12 - Cobertura de medicamentos no especificado
    Dado el plan con nombre "PlanJuventud" con costo unitario $500
    Y restricciones edad min 15, edad max 20, hijos max 0, admite conyuge "no"
    Y cobertura de visitas con copago $0 y con límite 2
    Cuando se registra el plan invalido
    Entonces se obtiene un error de plan sin cobertura de medicamentos

  Escenario: APLA1.13 - Edad mínima debe ser menor que edad máxima
    Dado el plan con nombre "PlanJuventud" con costo unitario $500
    Y restricciones edad min 20, edad max 15, hijos max 0, admite conyuge "no"
    Y cobertura de visitas con copago $0 y con límite 2
    Y cobertura de medicamentos 20%
    Cuando se registra el plan invalido
    Entonces se obtiene un error de plan con rango de edades invalido

  Escenario: APLA1.14 - Cobertura de medicamentos fuera de rango
    Dado el plan con nombre "PlanJuventud" con costo unitario $500
    Y restricciones edad min 15, edad max 20, hijos max 0, admite conyuge "no"
    Y cobertura de visitas con copago $0 y con límite 2
    Y cobertura de medicamentos -1%
    Cuando se registra el plan invalido
    Entonces se obtiene un error de plan con cobertura de medicamentos invalido

  Escenario: APLA1.15 - Número inválido de hijos
    Dado el plan con nombre "PlanJuventud" con costo unitario $500
    Y restricciones edad min 15, edad max 20, hijos max -1, admite conyuge "no"
    Y cobertura de visitas con copago $0 y con límite 2
    Y cobertura de medicamentos 20%
    Cuando se registra el plan invalido
    Entonces se obtiene un error de plan con cantidad de hijos invalido

  @wip
  Escenario: APLA1.16 - Valor del copago fuera de rango
    Dado el plan con nombre "PlanJuventud" con costo unitario $500
    Y restricciones edad min 15, edad max 20, hijos max 0, admite conyuge "no"
    Y cobertura de visitas con copago $-10 y con límite 2
    Y cobertura de medicamentos 20%
    Cuando se registra el plan invalido
    Entonces se obtiene un error de plan con copago invalido

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
