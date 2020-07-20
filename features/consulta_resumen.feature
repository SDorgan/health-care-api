# language: es

Característica: Consulta resumen
  Para poder obtener afiliados
  Como administrador de la prepaga
  Quiero que se pueda consultar el resumen de los gastos del mes

  Antecedentes:
    Dado el centro con nombre "Enfermeria del Castillo Negro"
    Y se registra el centro
    Y la prestación con nombre "Traumatologia"
    Y costo unitario de prestación $1000
    Y se registra la prestación
    Y la prestación con nombre "Clínica general"
    Y costo unitario de prestación $500
    Y se registra la prestación

  Escenario: RES1 - Consulta de resumen vacío
    Dado el plan con nombre "PlanCuervo" con costo unitario $500
    Y se registra el plan
    Dado el afiliado "JonSnow" afiliado a "PlanCuervo"
    Cuando consulta el resumen
    Entonces su saldo adicional es $0
    Y total a pagar es $500

  Escenario: RES3.1 - Consulta de resumen sin ninguna prestación cubierta y una consulta realizada
    Dado el plan con nombre "PlanCuervo" con costo unitario $500
    Y se registra el plan
    Dado el afiliado "JonSnow" afiliado a "PlanCuervo"
    Y que registró una atención por la prestación "Traumatologia"
    Cuando consulta el resumen
    Entonces su saldo adicional es $1000
    Y total a pagar es $1500

  Escenario: RES3.2 - Consulta de resumen sin ninguna prestación cubierta y dos consultas realizadas
    Dado el plan con nombre "PlanCuervo" con costo unitario $500
    Y se registra el plan
    Dado el afiliado "JonSnow" afiliado a "PlanCuervo"
    Y que registró una atención por la prestación "Traumatologia"
    Y que registró una atención por la prestación "Clínica general"
    Cuando consulta el resumen
    Entonces su saldo adicional es $1500
    Y total a pagar es $2000

  @wip
  Escenario: RES3.3 - Consulta de resumen con todas las prestaciones cubiertas
    Dado el plan con nombre "PlanCuervo" con costo unitario $500
    Y cobertura de visitas con límite 2
    Y se registra el plan
    Dado el afiliado "JonSnow" afiliado a "PlanCuervo"
    Y que registró una atención por la prestación "Traumatologia"
    Y que registró una atención por la prestación "Clínica general"
    Cuando consulta el resumen
    Entonces su saldo adicional es $0
    Y total a pagar es $500

  @wip
  Escenario: RES3.4 - Consulta de resumen con todas las prestaciones cubiertas por infinito
    Dado el plan con nombre "PlanCuervo" con costo unitario $500
    Y cobertura de visitas con límite infinito
    Y se registra el plan
    Dado el afiliado "JonSnow" afiliado a "PlanCuervo"
    Y que registró una atención por la prestación "Traumatologia"
    Y que registró una atención por la prestación "Clínica general"
    Y que registró una atención por la prestación "Clínica general"
    Y que registró una atención por la prestación "Clínica general"
    Y que registró una atención por la prestación "Clínica general"
    Y que registró una atención por la prestación "Traumatologia"
    Y que registró una atención por la prestación "Traumatologia"
    Cuando consulta el resumen
    Entonces su saldo adicional es $0
    Y total a pagar es $500

  @wip
  Escenario: RES4 - Consulta de resumen con algunas las prestaciones cubiertas
    Dado el plan con nombre "PlanCuervo" con costo unitario $500
    Y cobertura de visitas con límite 2
    Y se registra el plan
    Dado el afiliado "JonSnow" afiliado a "PlanCuervo"
    Y que registró una atención por la prestación "Traumatologia"
    Y que registró una atención por la prestación "Clínica general"
    Y que registró una atención por la prestación "Traumatologia"
    Entonces su saldo adicional es $1000
    Y total a pagar es $1500
