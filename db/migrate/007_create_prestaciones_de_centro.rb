Sequel.migration do
  up do
    create_table(:prestaciones_de_centros) do
      primary_key :id
      foreign_key :centro_id, :centros, key: :id
      foreign_key :prestacion_id, :prestaciones, key: :id
    end
  end

  down do
    drop_table(:prestaciones_de_centros)
  end
end
