class CompraMedicamentosRepository < BaseRepository
  def initialize
    super(:compras_medicamentos)
  end

  def save(compra_medicamentos)
    compra_medicamentos.created_on = Date.today

    id = insert(compra_medicamentos)

    compra_medicamentos.id = id

    compra_medicamentos
  end

  def find_by_afiliado(id)
    load_collection dataset.where(afiliado_id: id)
  end

  private

  def load_object(a_record)
    compra_medicamentos = CompraMedicamentos.new(a_record[:afiliado_id], a_record[:amount])
    compra_medicamentos.id = a_record[:id]
    compra_medicamentos.created_on = a_record[:created_on]

    compra_medicamentos
  end

  def changeset(compra_medicamentos)
    {
      afiliado_id: compra_medicamentos.afiliado_id,
      amount: compra_medicamentos.monto,
      created_on: compra_medicamentos.created_on
    }
  end
end
