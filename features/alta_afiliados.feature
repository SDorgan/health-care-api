# language: es

Característica: CRUD Alifiados
  Para poder obtener afiliados
  Como administrador de la prepaga
  Quiero poder asociar un afiliado a un plan

    Antecedentes:
        Dado el plan con nombre "PlanJuventud" con costo unitario $500
        Y restricciones edad min 15, edad max 20, hijos max 0, admite conyuge "no"
        Y cobertura de visitas con copago $0 y con límite 2
        Y cobertura de medicamentos 20%
        Y se registra el plan
        Y el plan con nombre "PlanFamiliar" con costo unitario $500
        Y restricciones edad min 15, edad max 20, hijos max 2, admite conyuge "si"
        Y cobertura de visitas con copago $0 y con límite 2
        Y cobertura de medicamentos 20%
        Y se registra el plan
    
    @mvp
    Escenario: RA1 - Registracion exitosa
        Dado el afiliado "hansolo" de 18 años, conyuge "no", hijos 0
        Cuando se registra al plan "PlanJuventud"
        Entonces obtiene un numero unico de afiliado
    @mvp
    Escenario: RA1.2 - Registracion fallida por plan inexistente
        Dado el afiliado "hansolo" de 18 años, conyuge "no", hijos 0
        Cuando se registra al plan "Familiar"
        Entonces obtiene un mensaje de error por plan inexistente
    
    @mvp
    Escenario: RA2.1 - Registracion fallida por edad supera el limite
        Dado el afiliado "hansolo" de 25 años, conyuge "no", hijos 0
        Cuando se registra al plan "PlanJuventud"
        Entonces obtiene un mensaje de error supera limite de edad
    
    @mvp
    Escenario: RA2.2 - Registracion fallida por edad no alcanza el minimo
        Dado el afiliado "hansolo" de 14 años, conyuge "no", hijos 0
        Cuando se registra al plan "PlanJuventud"
        Entonces obtiene un mensaje de error no alcanza el limite minimo de edad
    
    @mvp
    Escenario: RA3 - Registracion fallida por tener conyuge
        Dado el afiliado "hansolo" de 19 años, conyuge "si", hijos 0
        Cuando se registra al plan "PlanJuventud"
        Entonces obtiene un mensaje de error por tener conyuge
    
    @mvp
    Escenario: RA4 - Registracion fallida por tener hijos
        Dado el afiliado "hansolo" de 19 años, conyuge "no", hijos 1
        Cuando se registra al plan "PlanJuventud"
        Entonces obtiene un mensaje de error por tener hijos
    
    Escenario: RA4.1 - Registracion fallida por tener hijos
        Dado el plan con nombre "PlanFamiliarSinHijos" con costo unitario $500
        Y restricciones edad min 18, edad max 60, hijos max 0, requiere conyuge "si"
        Y cobertura de visitas con copago $0 y con límite 2
        Y cobertura de medicamentos 20%
        Y se registra el plan
        Dado el afiliado "hansolo" de 30 años, conyuge "no", hijos 1
        Cuando se registra al plan "PlanFamiliarSinHijos"
        Entonces obtiene un mensaje de error por tener hijos
        
    Escenario: RA5 - Registracion fallida por tener mas el maximo de hijos
        Dado el afiliado "hansolo" de 19 años, conyuge "no", hijos 3
        Cuando se registra al plan "PlanFamiliar"
        Entonces obtiene un mensaje de error por superar la cantidad de hijos maxima
    
    Escenario: RA6 - Registracion fallida por tener no tener hijos cuando necesita al menos uno
        Dado el afiliado "hansolo" de 19 años, conyuge "no", hijos 0
        Cuando se registra al plan "PlanFamiliar"
        Entonces obtiene un mensaje de error porque requiere hijos