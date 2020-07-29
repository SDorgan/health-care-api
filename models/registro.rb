require_relative './errors/edad_maxima_supera_limite_error'
require_relative './errors/edad_minima_no_alcanza_limite_error'
require_relative './errors/no_se_admite_conyuge_error'
require_relative './errors/se_requiere_conyuge_error'
require_relative './errors/no_se_admite_hijos_error'
require_relative './errors/plan_inexistente_error'
require_relative './errors/supera_limite_de_hijos_error'

class Registro
  def initialize(repo_afiliados, repo_planes)
    @repo_afiliados = repo_afiliados
    @repo_planes = repo_planes
  end

  def registrar_afiliado(data = {})
    plan = @repo_planes.find_by_name(data[:nombre_plan].to_s)

    validar_afiliado(data[:edad],
                     data[:cantidad_hijos],
                     data[:conyuge],
                     plan)

    afiliado = Afiliado.new(data[:nombre_afiliado], plan)
    afiliado.id_telegram = data[:id_telegram] unless data[:id_telegram].nil?

    @repo_afiliados.save(afiliado)
  end

  private

  def validar_afiliado(edad, cantidad_hijos, tiene_conyuge, plan)
    validar_edad_maxima(edad, plan)
    validar_edad_minima(edad, plan)
    validar_conyuge(tiene_conyuge, plan)
    validar_hijos(cantidad_hijos, plan)
    true
  end

  def validar_edad_maxima(edad, plan)
    raise EdadMaximaSuperaLimiteError if edad > plan.edad_maxima
  end

  def validar_edad_minima(edad, plan)
    raise EdadMinimaNoAlcanzaLimiteError if plan.edad_minima > edad
  end

  def validar_conyuge(tiene_conyuge, plan)
    raise NoSeAdmiteConyugeError if plan.conyuge.eql?(Plan::NO_ADMITE_CONYUGE) && tiene_conyuge
    raise SeRequiereConyugeError if plan.conyuge.eql?(Plan::REQUIERE_CONYUGE) && !tiene_conyuge
  end

  def validar_hijos(cantidad_hijos, plan)
    raise NoSeAdmiteHijosError if plan.cantidad_hijos_maxima.zero? && cantidad_hijos.positive?
    raise SuperaLimiteDeHijosError if cantidad_hijos > plan.cantidad_hijos_maxima
  end
end
