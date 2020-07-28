# language: es

Característica: Centros de Prestaciones
  Para poder saber donde atenderme
  Como administrador de la prepaga
  Quiero poder pedir los centros que dan una cierta prestacion

    Antecedentes:
        Dado el centro con nombre "Hospital Alemán"
        Y coordenadas geográficas latitud "-34.617670" y longitud "-58.368360"
        Y se registra el centro
        Y la prestación con nombre "Traumatología"
        Y costo unitario de prestación $1200
        Y se registra la prestación
        Y se le agrega la prestación "Traumatología" al centro "Hospital Alemán"
        Y se actualiza el centro exitosamente
        Y la prestación con nombre "Odontología"
        Y costo unitario de prestación $2000
        Y se registra la prestación

    @mvp
    Escenario: CCP1 - Consulta por centro que tiene traumatología, cuando existe uno
        Dada la prestación "Traumatología"
        Cuando realizo la consulta de centro médico
        Entonces obtengo "Hospital Alemán" como resultado

    @mvp
    Escenario: CCP2 - Consulta por centro que tiene odontología con respuesta vacía
        Dada la prestación "Odontología"
        Cuando realizo la consulta de centro médico
        Entonces se obtiene una respuesta vacía

    @mvp
    Escenario: CCP3 - Consulta por centro que tiene cirujía con error por prestación inexistente
        Dada la prestación "Cirujía"
        Cuando realizo la consulta de centro médico
        Entonces obtiene un error por prestación no existente
