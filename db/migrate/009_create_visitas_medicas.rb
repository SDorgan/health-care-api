Sequel.migration do
  up do
    create_table(:visitas_medicas) do
      primary_key :id
      foreign_key :afiliado_id, :afiliados, key: :id
      foreign_key :prestacion_id, :prestaciones, key: :id
      Date :created_on
    end
  end

  down do
    drop_table(:visitas_medicas)
  end
end
