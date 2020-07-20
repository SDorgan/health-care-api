class CompraMedicamentosRepository
  def initialize
    @table_name = :compras_medicamentos
  end

  def find(id)
    load_object(dataset.first!(pk_column => id))
  end

  def find_by_afiliado(id)
    load_collection dataset.where(afiliado_id: id)
  end

  def save(compra_medicamentos)
    id = insert(compra_medicamentos)

    compra_medicamentos.id = id

    compra_medicamentos
  end

  def destroy(a_record)
    find_dataset_by_id(a_record.id).delete.positive?
  end
  alias delete destroy

  def delete_all
    dataset.delete
  end

  private

  def insert(a_record)
    a_record.created_on = Date.today

    dataset.insert(changeset(a_record))
  end

  def dataset
    DB[@table_name]
  end

  def load_object(a_record)
    compra_medicamentos = CompraMedicamentos.new(a_record[:afiliado_id], a_record[:amount])
    compra_medicamentos.id = a_record[:id]
    compra_medicamentos.created_on = a_record[:created_on]

    compra_medicamentos
  end

  def load_collection(rows)
    rows.map { |a_record| load_object(a_record) }
  end

  def pk_column
    Sequel[@table_name][:id]
  end

  def changeset(compra_medicamentos)
    {
      afiliado_id: compra_medicamentos.afiliado_id,
      amount: compra_medicamentos.monto,
      created_on: compra_medicamentos.created_on
    }
  end
end
