# language: es

Característica: Prestaciones para un Plan
  Para que los afiliados puedan atenderse
  Como administrador de la prepaga
  Quiero poder agregar prestaciones que incluye el descuento de mis planes

    Antecedentes:
        Dado el plan con nombre "PlanJuventud" con costo unitario $500
        Y se registra el plan
        Y la prestación con nombre "Traumatología"
        Y costo unitario de prestación $1200
        Y se registra la prestación

    @mvp
    Escenario: APLAPRES1 - Alta exitosa traumatología para PlanJuventud
        Dado el plan llamado "PlanJuventud"
        Cuando se le agrega la prestación "Traumatología"
        Entonces se actualiza el plan exitosamente
