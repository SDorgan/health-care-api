class Plan
  NO_ADMITE_CONYUGE = 'NO_ADMITE_CONYUGE'.freeze
  ADMITE_CONYUGE = 'ADMITE_CONYUGE'.freeze
  REQUIERE_CONYUGE = 'REQUIERE_CONYUGE'.freeze

  attr_accessor :id, :nombre, :costo,
                :cobertura_visitas, :cobertura_medicamentos,
                :edad_minima, :edad_maxima,
                :cantidad_hijos_maxima, :conyuge

  def initialize(data = {})
    validate(data)
    @nombre = data[:nombre]
    @costo = data[:costo]
    @cobertura_visitas = data[:cobertura_visitas]
    @cobertura_medicamentos = data[:cobertura_medicamentos]
    @edad_minima = data[:edad_minima]
    @edad_maxima = data[:edad_maxima]
    @cantidad_hijos_maxima = data[:cantidad_hijos_maxima]
    @conyuge = data[:conyuge]
  end

  def self.mapeo_conyuge
    { NO_ADMITE_CONYUGE => 0,
      ADMITE_CONYUGE => 1,
      REQUIERE_CONYUGE => 2 }
  end

  private

  def validate(data)
    raise PlanSinNombreError if data[:nombre].nil?
    raise PlanSinCostoError if data[:costo].nil?
    raise PlanSinRangoDeEdadesError if data[:edad_maxima].nil?
  end
end
