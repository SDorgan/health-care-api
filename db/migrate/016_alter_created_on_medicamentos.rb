Sequel.migration do
  up do
    set_column_type :compras_medicamentos, :created_on, :timestamp
  end

  down do
    set_column_type :compras_medicamentos, :created_on, :date
  end
end
