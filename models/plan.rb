require_relative '../app/errors/edad_maxima_supera_limite_error'
require_relative '../app/errors/edad_minima_no_alcanza_limite_error'
require_relative '../app/errors/no_se_admite_conyuge_error'
require_relative '../app/errors/se_requiere_conyuge_error'
require_relative '../app/errors/no_se_admite_hijos_error'
require_relative '../app/errors/plan_inexistente_error'
require_relative '../app/errors/se_requiere_hijos_error'
require_relative '../app/errors/supera_limite_de_hijos_error'

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

  def self.mapeo_conyuge
    { NO_ADMITE_CONYUGE => 0,
      ADMITE_CONYUGE => 1,
      REQUIERE_CONYUGE => 2 }
  end

  def validar_plan_con(edad, cantidad_hijos, tiene_conyuge)
    validar_edad_maxima(edad) unless @edad_maxima.nil?
    validar_edad_minima(edad) unless @edad_minima.nil?
    validar_conyuge(tiene_conyuge) unless @conyuge.nil?
    validar_hijos(cantidad_hijos) unless @cantidad_hijos_maxima.nil?
    true
  end

  private

  def validar_edad_maxima(edad)
    raise EdadMaximaSuperaLimiteError if edad > @edad_maxima
  end

  def validar_edad_minima(edad)
    raise EdadMinimaNoAlcanzaLimiteError if @edad_minima > edad
  end

  def validar_conyuge(tiene_conyuge)
    raise NoSeAdmiteConyugeError if @conyuge.eql?(NO_ADMITE_CONYUGE) && tiene_conyuge
    raise SeRequiereConyugeError if @conyuge.eql?(REQUIERE_CONYUGE) && !tiene_conyuge
  end

  def validar_hijos(cantidad_hijos)
    raise NoSeAdmiteHijosError if @cantidad_hijos_maxima.zero? && cantidad_hijos.positive?
    raise SeRequiereHijosError if @cantidad_hijos_maxima.positive? && cantidad_hijos.zero?
    raise SuperaLimiteDeHijosError if cantidad_hijos > @cantidad_hijos_maxima
  end
end
