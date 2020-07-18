class ResumenResponseBuilder
  def self.create_from(resumen)
    {
      'resumen': {
        'afiliado': resumen.afiliado.nombre,
        'plan': {
          'nombre': resumen.plan.nombre,
          'costo': resumen.plan.costo
        },
        'adicional': resumen.costo_adicional,
        'total': resumen.total
      }
    }.to_json
  end
end
