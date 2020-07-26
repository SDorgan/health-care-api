class ResumenResponseBuilder
  def self.create_from(resumen)
    items = []

    resumen.items.each do |my_item|
      items << build_item(my_item)
    end

    {
      'resumen': {
        'afiliado': resumen.afiliado.nombre,
        'plan': {
          'nombre': resumen.plan.nombre,
          'costo': resumen.plan.costo
        },
        'adicional': resumen.costo_adicional,
        'total': resumen.total,
        'items': items
      }
    }.to_json
  end

  def self.build_item(my_item)
    output = {
      'concepto': my_item.concepto,
      'fecha': my_item.fecha.strftime('%d/%m/%Y'),
      'costo': my_item.costo
    }

    output
  end

  private_class_method :build_item
end
