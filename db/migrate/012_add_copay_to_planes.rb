Sequel.migration do
  up do
    add_column :planes, :copay, Integer, default: 0
  end

  down do
    drop_column :planes, :copay
  end
end
