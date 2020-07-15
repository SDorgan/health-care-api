# language: es

Característica: CRUD Centros
  Para poder obtener afiliados
  Como administrador de la prepaga
  Quiero poder manejar los centros medicos

  Escenario: ACEN1.1 - Alta exitosa de centro con nombre
    Dado el centro con nombre "Hospital Alemán"
    Cuando se registra el centro
    Entonces se registra exitosamente
