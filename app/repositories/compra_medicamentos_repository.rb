require_relative '../../lib/date_manager'

class CompraMedicamentosRepository < BaseRepository
  def initialize
    super(:compras_medicamentos)
  end

  def save(compra_medicamentos)
    id = insert(compra_medicamentos)

    compra_medicamentos.id = id

    compra_medicamentos
  end

  def find_by_afiliado(criteria = {})
    id = criteria[:id]

    fecha = criteria[:fecha]

    if !fecha.nil?
      load_collection dataset.where(afiliado_id: id,
                                    created_on: (fecha[:inicio]..fecha[:fin]))
    else
      load_collection dataset.where(afiliado_id: id)
    end
  end

  private

  def load_object(a_record)
    fecha_compra = a_record[:created_on]
    compra = CompraMedicamentos.new(a_record[:afiliado_id], a_record[:amount], fecha_compra)
    compra.id = a_record[:id]

    compra
  end

  def changeset(compra_medicamentos)
    {
      afiliado_id: compra_medicamentos.afiliado_id,
      amount: compra_medicamentos.monto,
      created_on: compra_medicamentos.fecha_compra
    }
  end
end
