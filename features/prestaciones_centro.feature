# language: es

Característica: Prestaciones para un Centro
  Para que los afiliados puedan atenderse
  Como administrador de la prepaga
  Quiero poder agregar prestaciones para los centros que las cubren

  Antecedentes:
    Dado el centro con nombre "Hospital Alemán"
    Y coordenadas geográficas latitud "-34.617670" y longitud "-58.368360"
    Y se registra el centro
    Y la prestación con nombre "Traumatología"
    Y costo unitario de prestación $1200
    Y se registra la prestación

  Escenario: ACENPRES1 - Alta exitosa traumatología para Hospital Alemán
    Dado el centro llamado "Hospital Alemán"
    Cuando se le agrega la prestación "Traumatología" al centro "Hospital Alemán"
    Entonces se actualiza el centro exitosamente

  @mvp
  @wip
  Escenario: ACENPRES2 - Alta fallida por prestación inexistente
    Dado el centro llamado "Hospital Alemán"
    Cuando se le agrega la prestación "Cirugía" al centro "Hospital Alemán"
    Entonces obtiene un error por prestación no existente

  @mvp
  @wip
  Escenario: ACENPRES3 - Alta fallida por prestación repetida
    Dado el centro llamado "Hospital Alemán"
    Y se le agrega la prestación "Traumatología" al centro "Hospital Alemán"
    Y se actualiza el centro exitosamente
    Cuando se le agrega la prestación "Traumatología" al centro "Hospital Alemán"
    Entonces se obtiene un error por prestación repetida

  @mvp
  @wip
  Escenario: ACENPRES4 - Alta fallida por centro inexistente
    Dado el centro llamado "Hospital Italiano"
    Y se le agrega la prestación "Traumatología" al centro "Hospital Italiano"
    Entonces obtiene un error por centro no existente
