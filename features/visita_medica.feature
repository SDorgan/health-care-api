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
    Y el plan con nombre "PlanCuervo" con costo unitario $500
    Y se registra el plan

  Escenario: REGAM1 - Registro exitoso
    Dado el afiliado "JonSnow" afiliado a "PlanCuervo"
    Cuando se atiende por "Traumatologia" en el centro "Enfermeria del Castillo Negro"
    Entonces se registra la prestación con un identificador único
