# language: es

Característica: Medicamentos
  Para cobrar el monto total del medicamento a la obra social
  Como vendedor de la farmacia
  Quiero poder cargar cuando un afiliado compra medicamentos

  Antecedentes:
    Dado el plan con nombre "PlanCuervo" con costo unitario $500
    Y se registra el plan

  @mvp
  @wip
  Escenario: REGMED1 - Registro exitoso de la compra de medicamentos
      Dado el afiliado "JonSnow" afiliado a "PlanCuervo"
      Cuando realiza una compra de medicamentos por $1000
      Entonces se registra la compra con un identificador único
