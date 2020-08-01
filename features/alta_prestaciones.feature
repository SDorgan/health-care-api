# language: es

Característica: CRUD Prestaciones
  Para que los afiliados puedan atenderse
  Como administrador de la prepaga
  Quiero poder manejar las prestaciones

  Escenario: APRE1 - Alta exitosa de prestacion traumatología
    Dado la prestación con nombre "Traumatología"
    Y costo unitario de prestación $1200
    Cuando se registra la prestación
    Entonces la prestación se registra exitosamente

  Escenario: APRE2 - Alta fallida de prestacion por no indicar costo
    Dado la prestación con nombre "Odontología"
    Cuando se registra la prestación invalida
    Entonces se obtiene un mensaje de error por no indicar costo

  Escenario: APRE3 - Alta fallida de prestación por costo negativo
    Dado la prestación con nombre "Traumatología"
    Y costo unitario de prestación $-100
    Cuando se registra la prestación invalida
    Entonces se obtiene un mensaje de error por costo negativo

  Escenario: APRE4 - Alta fallida de prestación por costo ingresado como texto
    Dado la prestación con nombre "Traumatología"
    Y costo unitario de prestación "100"
    Cuando se registra la prestación invalida
    Entonces se obtiene un mensaje de error de que el costo debe ser numerico
