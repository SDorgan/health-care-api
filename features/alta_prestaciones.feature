# language: es

Característica: CRUD Prestaciones
  Para que los afiliados puedan atenderse
  Como administrador de la prepaga
  Quiero poder manejar las prestaciones

    @mvp
    Escenario: APRE1 - Alta exitosa de prestacion traumatología
        Dado la prestación con nombre "Traumatología"
        Y costo unitario de prestación $1200
        Cuando se registra la prestación
        Entonces la prestación se registra exitosamente

