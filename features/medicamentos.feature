# language: es

Característica: Medicamentos
  Para cobrar el monto total del medicamento a la obra social
  Como vendedor de la farmacia
  Quiero poder cargar cuando un afiliado compra medicamentos

  Antecedentes:
    Dado el plan con nombre "PlanCuervo" con costo unitario $500
    Y restricciones edad min 15, edad max 20, hijos max 0, admite conyuge "no"
    Y cobertura de visitas con copago $0 y con límite 2
    Y cobertura de medicamentos 20%
    Y se registra el plan

  @mvp
  Escenario: REGMED1 - Registro exitoso de la compra de medicamentos
      Dado el afiliado "JonSnow" afiliado a "PlanCuervo"
      Cuando realiza una compra de medicamentos por $1000
      Entonces se registra la compra con un identificador único
