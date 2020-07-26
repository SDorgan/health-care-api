Sequel.migration do
  up do
    set_column_type :visitas_medicas, :created_on, :timestamp
  end

  down do
    set_column_type :visitas_medicas, :created_on, :date
  end
end
