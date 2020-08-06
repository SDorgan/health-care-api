class Resumen
  attr_accessor :afiliado, :plan, :items

  def initialize(afiliado, repo_visitas, repo_medicamentos)
    @afiliado = afiliado
    @repo_visitas = repo_visitas
    @repo_medicamentos = repo_medicamentos
    @items = []
  end

  def generar
    @plan = @afiliado.plan

    @visitas = @repo_visitas.find_by_afiliado(id: @afiliado.id)
    @compras_medicamentos = @repo_medicamentos.find_by_afiliado(id: @afiliado.id)

    aplicar_descuentos
    agregar_items
  end

  def costo_adicional
    adicional_visitas + adicional_medicamentos
  end

  def total
    @plan.costo + costo_adicional
  end

  private

  def aplicar_descuentos
    @visitas = @plan.cobertura_visitas.aplicar(@visitas)
    @compras_medicamentos = @plan.cobertura_medicamentos.aplicar(@compras_medicamentos)
  end

  def adicional_visitas
    @visitas.map(&:costo).inject(0, :+)
  end

  def adicional_medicamentos
    @compras_medicamentos.map(&:costo_final).inject(0, :+)
  end

  def agregar_items
    agregar_items_de_visitas
    agregar_items_de_medicamentos
    @items = @items.sort_by(&:fecha)
  end

  def agregar_items_de_visitas
    @visitas.map do |visita|
      concepto = "#{visita.prestacion.nombre} - #{visita.centro.nombre}"
      @items << ItemResumen.new(concepto, visita.fecha_visita, visita.costo)
    end
  end

  def agregar_items_de_medicamentos
    @compras_medicamentos.map do |compra|
      @items << ItemResumen.new('Medicamentos', compra.fecha_compra, compra.costo_final)
    end
  end
end
