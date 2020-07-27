class Plan
  NO_ADMITE_CONYUGE = 'NO_ADMITE_CONYUGE'.freeze
  ADMITE_CONYUGE = 'ADMITE_CONYUGE'.freeze
  REQUIERE_CONYUGE = 'REQUIERE_CONYUGE'.freeze

  attr_accessor :id, :nombre, :costo,
                :cobertura_visitas, :cobertura_medicamentos, :edad_minima,
                :edad_maxima, :cantidad_hijos_maxima, :conyuge

  def initialize(data = {})
    @nombre = data[:nombre]
    @costo = data[:costo]
    @cobertura_visitas = data[:cobertura_visitas]
    @cobertura_medicamentos = data[:cobertura_medicamentos]
    @edad_minima = data[:edad_minima]
    @edad_maxima = data[:edad_maxima]
    @cantidad_hijos_maxima = data[:cantidad_hijos_maxima]
    @conyuge = data[:conyuge]
  end

  def self.no_admite_conyuge
    NO_ADMITE_CONYUGE
  end

  def self.admite_conyuge
    ADMITE_CONYUGE
  end

  def self.requiere_conyuge
    REQUIERE_CONYUGE
  end
end
