Sequel.migration do
  up do
    create_table(:planes) do
      primary_key :id
      String :name
    end
  end

  down do
    drop_table(:planes)
  end
end
