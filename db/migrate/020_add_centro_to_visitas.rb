Sequel.migration do
  up do
    add_column :visitas_medicas, :centro_id, Integer
  end

  down do
    drop_column :visitas_medicas, :centro_id
  end
end
