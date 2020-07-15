Sequel.migration do
  up do
    create_table(:centros) do
      primary_key :id
      String :name
    end
  end

  down do
    drop_table(:centros)
  end
end
