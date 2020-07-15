Sequel.migration do
  up do
    add_column :planes, :cost, Integer, default: 0
  end

  down do
    drop_column :planes, :cost
  end
end
