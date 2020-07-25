# language: es

Característica: Registro afiliado sospechoso de COVID-19
  Para que los afiliados sepan si son sospechosos de covid
  Como administrador de la prepaga
  Quiero que se pueda hacer un diagnóstico de covid en la app

    Antecedentes:
      Dado el plan con nombre "PlanJuventud" con costo unitario $500
      Y se registra el plan

    Escenario: REGCOVID1 - Registro afiliado sospechoso de COVID
        Dado el afiliado "Lionel Messi" afiliado a "PlanJuventud"
        Cuando se registra caso sospechoso de COVID
        Entonces se obtiene que es sospechoso
        Y queda registrado que el afiliado es sospechoso
