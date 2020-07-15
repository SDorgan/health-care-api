# language: es

Característica: Prestaciones para un Centro
  Para que los afiliados puedan atenderse
  Como administrador de la prepaga
  Quiero poder agregar prestaciones para los centros que las cubren

  Antecedentes:
    Dado el centro con nombre "Hospital Alemán"
    Y se registra el centro
    Y la prestación con nombre "Traumatología"
    Y el costo unitario de prestación $1200
    Y se registra la prestación

  @wip
  Escenario: ACENPRES1 - Alta exitosa traumatología para Hospital Alemán
    Dado el centro con nombre "Hospital Alemán"
    Cuando se agrega la prestación "Traumatología"
    Entonces se actualiza el centro exitosamente
