# language: es

Característica: Registrar visita médica
  Para poder generar un resumen del afiliado
  Como medico de un centro
  Quiero poder registrar visitas médicas de los afiliados

  Antecedentes:
    Dado el centro con nombre "Enfermeria del Castillo Negro"
    Y se registra el centro
    Y la prestación con nombre "Traumatologia"
    Y costo unitario de prestación $1200
    Y se registra la prestación
    Y se le agrega la prestación "Traumatologia" al centro
    Y la prestación con nombre "Odontologia"
    Y costo unitario de prestación $1000
    Y se registra la prestación
    Y se le agrega la prestación "Odontologia" al centro
    Y el plan con nombre "PlanCuervo" con costo unitario $500
    Y se registra el plan

  Escenario: REGAM1 - Registro exitoso
    Dado el afiliado "JonSnow" afiliado a "PlanCuervo"
    Cuando se atiende por "Traumatologia" en el centro "Enfermeria del Castillo Negro"
    Entonces se registra la prestación con un identificador único

  @mvp
  Escenario: REGAM2 - Registro fallido por usuario no afiliado
    Dado el usuario "Tirion" que no esta afiliado
    Cuando se atiende por "Traumatologia" en el centro "Enfermeria del Castillo Negro"
    Entonces obtiene un error por no estar afiliado

  @mvp
  Escenario: REGAM3 - Registro fallido por prestación no existente
    Dado el afiliado "JonSnow" afiliado a "PlanCuervo"
    Cuando se atiende por "Pediatria" en el centro "Enfermeria del Castillo Negro"
    Entonces obtiene un error por prestación no existente

  @mvp
  Escenario: REGAM4 - Registro fallido por centro no existente
    Dado el afiliado "JonSnow" afiliado a "PlanCuervo"
    Cuando se atiende por "Traumatologia" en el centro "Enfermeria de La Roca"
    Entonces obtiene un error por centro no existente

  @mvp
  @wip
  Escenario: REGAM5 - Registro fallido por prestación no ofrecida en el centro
    Dado el afiliado "JonSnow" afiliado a "PlanCuervo"
    Cuando se atiende por "Pediatria" en el centro "Enfermeria del Castillo Negro"
    Entonces obtiene un error por prestacion no ofrecida en el centro

