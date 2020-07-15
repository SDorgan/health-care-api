Sequel.migration do
  up do
    create_table(:prestaciones) do
      primary_key :id
      String :name
      Integer :cost
    end
  end

  down do
    drop_table(:prestaciones)
  end
end
