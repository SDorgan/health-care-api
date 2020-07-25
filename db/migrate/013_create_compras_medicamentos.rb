Sequel.migration do
  up do
    create_table(:compras_medicamentos) do
      primary_key :id
      foreign_key :afiliado_id, :afiliados, key: :id
      Integer :amount
      Date :created_on
    end
  end

  down do
    drop_table(:compras_medicamentos)
  end
end
