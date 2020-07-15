Sequel.migration do
  up do
    create_table(:afiliados) do
      primary_key :id
      String :name
      String :id_telegram
      foreign_key :plan_id, :planes, key: :id
    end
  end

  down do
    drop_table(:afiliados)
  end
end
