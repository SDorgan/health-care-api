Sequel.migration do
  up do
    create_table(:afiliados) do
      primary_key :id
      String :name
      String :id_telegram
      Integer :id_plan
    end
  end

  down do
    drop_table(:afiliados)
  end
end
