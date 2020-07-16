# language: es

Característica: Registrar visita médica
  Para poder generar un resumen del afiliado
  Como medico de un centro
  Quiero poder registrar visitas médicas de los afiliados

  Antecedentes:
    Dado el centro "Enfermeria del Castillo Negro"
    Y la prestación "Traumatología" y costo $1000
    Y el plan con "PlanCuervo" con costo unitario $500

  @wip
  Escenario: REGAM1 - Registro exitoso
    Dado el afiliado "JonSnow" al plan "PlanCuervo"
    Cuando se atiende por "Traumatologia" en el centro "Enfermeria del Castillo Negro"
    Entonces se registra la prestación con un identificador único
