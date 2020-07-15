# language: es

Característica: CRUD Alifiados
  Para poder obtener afiliados
  Como administrador de la prepaga
  Quiero poder asociar un afiliado a un plan

    Antecedentes:
        Dado el plan con nombre "PlanJuventud" con costo unitario $500
        Y se registra el plan

    @mvp
    Escenario: RA1.1 - Registracion exitosa
        Dado el afiliado "hansolo" de 18 años, conyuge "no", hijos 0
        Cuando se registra al plan "PlanJuventud"
        Entonces obtiene un numero unico de afiliado
