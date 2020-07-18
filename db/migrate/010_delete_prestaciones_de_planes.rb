Sequel.migration do
  up do
    drop_table(:prestaciones_de_planes)
  end

  down do
    create_table(:prestaciones_de_planes) do
      primary_key :id
      foreign_key :plan_id, :planes, key: :id
      foreign_key :prestacion_id, :prestaciones, key: :id
    end
  end
end
