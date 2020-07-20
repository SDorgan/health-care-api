# language: es

Característica: Diagnóstico COVID-19
  Para que los afiliados sepan si son sospechosos de covid
  Como administrador de la prepaga
  Quiero que se pueda hacer un diagnóstico de covid en la app

    Antecedentes:
      Dado el plan con nombre "PlanJuventud" con costo unitario $500
      Y se registra el plan
    @wip
    Escenario: DIAG1.1 - Diagnóstico por temperatura sin COVID
        Dado el afiliado "Lionel Messi" afiliado a "PlanJuventud"
        Cuando no se registra caso sospechoso de COVID
        Entonces se obtiene que no es sospechoso
    @wip
    Escenario: DIAG2.1 - Diagnóstico por temperatura con COVID
        Dado el afiliado "Lionel Messi" afiliado a "PlanJuventud"
        Cuando se registra caso sospechoso de COVID
        Entonces se obtiene que es sospechoso
        Y queda registrado que el afiliado es sospechoso
