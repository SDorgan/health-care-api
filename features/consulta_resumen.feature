# language: es

Característica: Consulta resumen
  Para poder obtener afiliados
  Como administrador de la prepaga
  Quiero que se pueda consultar el resumen de los gastos del mes

  Antecedentes:
    Dado el centro con nombre "Enfermeria del Castillo Negro"
    Y coordenadas geográficas latitud "-34.617670" y longitud "-58.368360"
    Y se registra el centro
    Y la prestación con nombre "Traumatologia"
    Y costo unitario de prestación $1000
    Y se registra la prestación
    Y se le agrega la prestación "Traumatologia" al centro "Enfermeria del Castillo Negro"
    Y la prestación con nombre "Clínica general"
    Y costo unitario de prestación $500
    Y se registra la prestación
    Y se le agrega la prestación "Clínica general" al centro "Enfermeria del Castillo Negro"

  Escenario: RES1 - Consulta de resumen vacío
    Dado el plan con nombre "PlanCuervo" con costo unitario $500
    Y cobertura de visitas con copago $0 y con límite 0
    Y restricciones edad min 15, edad max 30, hijos max 0, admite conyuge "no"
    Y se registra el plan
    Dado el afiliado "JonSnow" afiliado a "PlanCuervo"
    Cuando consulta el resumen
    Entonces su saldo adicional es $0
    Y total a pagar es $500

  @mvp
  Escenario: RES2 - Consulta de resumen fallido por persona no afiliada
    Dado el usuario "Tirion" que no esta afiliado
    Cuando consulta el resumen
    Entonces obtiene un error

  Escenario: RES3.1 - Consulta de resumen sin ninguna prestación cubierta y una consulta realizada
    Dado el plan con nombre "PlanCuervo" con costo unitario $500
    Y cobertura de visitas con copago $0 y con límite 0
    Y restricciones edad min 15, edad max 30, hijos max 0, admite conyuge "no"
    Y se registra el plan
    Dado el afiliado "JonSnow" afiliado a "PlanCuervo"
    Y que registró una atención por la prestación "Traumatologia" en el centro "Enfermeria del Castillo Negro"
    Cuando consulta el resumen
    Entonces su saldo adicional es $1000
    Y total a pagar es $1500

  Escenario: RES3.2 - Consulta de resumen sin ninguna prestación cubierta y dos consultas realizadas
    Dado el plan con nombre "PlanCuervo" con costo unitario $500
    Y cobertura de visitas con copago $0 y con límite 0
    Y restricciones edad min 15, edad max 30, hijos max 0, admite conyuge "no"
    Y se registra el plan
    Dado el afiliado "JonSnow" afiliado a "PlanCuervo"
    Y que registró una atención por la prestación "Traumatologia" en el centro "Enfermeria del Castillo Negro"
    Y que registró una atención por la prestación "Clínica general" en el centro "Enfermeria del Castillo Negro"
    Cuando consulta el resumen
    Entonces su saldo adicional es $1500
    Y total a pagar es $2000

  Escenario: RES3.3 - Consulta de resumen con todas las prestaciones cubiertas
    Dado el plan con nombre "PlanCuervo" con costo unitario $500
    Y cobertura de visitas con copago $0 y con límite 2
    Y restricciones edad min 15, edad max 30, hijos max 0, admite conyuge "no"
    Y se registra el plan
    Dado el afiliado "JonSnow" afiliado a "PlanCuervo"
    Y que registró una atención por la prestación "Traumatologia" en el centro "Enfermeria del Castillo Negro"
    Y que registró una atención por la prestación "Clínica general" en el centro "Enfermeria del Castillo Negro"
    Cuando consulta el resumen
    Entonces su saldo adicional es $0
    Y total a pagar es $500

  Escenario: RES3.4 - Consulta de resumen con todas las prestaciones cubiertas por infinito
    Dado el plan con nombre "PlanCuervo" con costo unitario $500
    Y cobertura de visitas con copago $0 y con límite infinito
    Y se registra el plan
    Dado el afiliado "JonSnow" afiliado a "PlanCuervo"
    Y que registró una atención por la prestación "Traumatologia" en el centro "Enfermeria del Castillo Negro"
    Y que registró una atención por la prestación "Clínica general" en el centro "Enfermeria del Castillo Negro"
    Y que registró una atención por la prestación "Clínica general" en el centro "Enfermeria del Castillo Negro"
    Y que registró una atención por la prestación "Clínica general" en el centro "Enfermeria del Castillo Negro"
    Y que registró una atención por la prestación "Clínica general" en el centro "Enfermeria del Castillo Negro"
    Y que registró una atención por la prestación "Traumatologia" en el centro "Enfermeria del Castillo Negro"
    Y que registró una atención por la prestación "Traumatologia" en el centro "Enfermeria del Castillo Negro"
    Cuando consulta el resumen
    Entonces su saldo adicional es $0
    Y total a pagar es $500

  Escenario: RES4 - Consulta de resumen con algunas las prestaciones cubiertas
    Dado el plan con nombre "PlanCuervo" con costo unitario $500
    Y cobertura de visitas con copago $0 y con límite 2
    Y restricciones edad min 15, edad max 30, hijos max 0, admite conyuge "no"
    Y se registra el plan
    Dado el afiliado "JonSnow" afiliado a "PlanCuervo"
    Y que registró una atención por la prestación "Traumatologia" en el centro "Enfermeria del Castillo Negro"
    Y que registró una atención por la prestación "Clínica general" en el centro "Enfermeria del Castillo Negro"
    Y que registró una atención por la prestación "Traumatologia" en el centro "Enfermeria del Castillo Negro"
    Cuando consulta el resumen
    Entonces su saldo adicional es $1000
    Y total a pagar es $1500

  Escenario: RES5 - Consulta de resumen con todas las prestaciones cubiertas con copago
    Dado el plan con nombre "PlanOso" con costo unitario $700
    Y cobertura de visitas con copago $10 y con límite 2
    Y restricciones edad min 15, edad max 30, hijos max 0, admite conyuge "no"
    Y se registra el plan
    Dado el afiliado "Jorah" afiliado a "PlanOso"
    Y que registró una atención por la prestación "Traumatologia" en el centro "Enfermeria del Castillo Negro"
    Y que registró una atención por la prestación "Clínica general" en el centro "Enfermeria del Castillo Negro"
    Cuando consulta el resumen
    Entonces su saldo adicional es $20
    Y total a pagar es $720

  Escenario: RES6 - Consulta de resumen con dos prestaciones cubiertas con copago y una extra
    Dado el plan con nombre "PlanOso" con costo unitario $700
    Y cobertura de visitas con copago $10 y con límite 2
    Y restricciones edad min 15, edad max 30, hijos max 0, admite conyuge "no"
    Y se registra el plan
    Dado el afiliado "Jorah" afiliado a "PlanOso"
    Y que registró una atención por la prestación "Traumatologia" en el centro "Enfermeria del Castillo Negro"
    Y que registró una atención por la prestación "Clínica general" en el centro "Enfermeria del Castillo Negro"
    Y que registró una atención por la prestación "Clínica general" en el centro "Enfermeria del Castillo Negro"
    Cuando consulta el resumen
    Entonces su saldo adicional es $520
    Y total a pagar es $1220

  @mvp
  Escenario: RES7 - Consulta de resumen con compra de medicamentos
    Dado el plan con nombre "PlanOso" con costo unitario $700
    Y cobertura de visitas con copago $10 y con límite 2 y medicamentos 80%
    Y restricciones edad min 15, edad max 30, hijos max 0, admite conyuge "no"
    Y se registra el plan
    Dado el afiliado "Jorah" afiliado a "PlanOso"
    Y realiza una compra de medicamentos por $1000
    Cuando consulta el resumen
    Entonces su saldo adicional es $200
    Y total a pagar es $900

  @mvp
  Escenario: RES8 - Consulta de resumen con compra de medicamentos y atenciones
    Dado el plan con nombre "PlanOso" con costo unitario $700
    Y cobertura de visitas con copago $10 y con límite 2 y medicamentos 80%
    Y restricciones edad min 15, edad max 30, hijos max 0, admite conyuge "no"
    Y se registra el plan
    Dado el afiliado "Jorah" afiliado a "PlanOso"
    Y realiza una compra de medicamentos por $1000
    Y que registró una atención por la prestación "Traumatologia" en el centro "Enfermeria del Castillo Negro"
    Cuando consulta el resumen
    Entonces su saldo adicional es $210
    Y total a pagar es $910

  @mvp
  Escenario: RES9 - Consulta de resumen tras visitar al traumatólogo lista la visita
    Dado el plan con nombre "PlanOso" con costo unitario $700
    Y cobertura de visitas con copago $10 y con límite 2 y medicamentos 80%
    Y restricciones edad min 15, edad max 30, hijos max 0, admite conyuge "no"
    Y se registra el plan
    Dado el afiliado "Jorah" afiliado a "PlanOso"
    Y que registró una atención por la prestación "Traumatologia" en el centro "Enfermeria del Castillo Negro"
    Y que registró una atención por la prestación "Clínica general" en el centro "Enfermeria del Castillo Negro"
    Y que registró una atención por la prestación "Clínica general" en el centro "Enfermeria del Castillo Negro"
    Y realiza una compra de medicamentos por $1000
    Cuando consulta el resumen
    Entonces su saldo adicional es $720
    Y total a pagar es $1420
    Y posee una visita por la prestación "Traumatologia" con costo $10
    Y posee una visita por la prestación "Clínica general" con costo $10
    Y posee una visita por la prestación "Clínica general" con costo $500
    Y posee una compra de medicamentos con costo $200
