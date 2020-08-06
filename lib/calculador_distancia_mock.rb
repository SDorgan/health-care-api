class CalculadorDistanciaMock
  def obtener_direcciones_a_punto(_centros, _latitud, _longitud)
    value = JSON.parse(ENV['DISTANCIAS'])
    { distancias: value['distancias'], direcciones: value['direcciones'] }
  end
end
