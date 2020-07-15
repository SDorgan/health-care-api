Sequel.migration do
  up do
    add_column :planes, :precio, Integer, default: 0
  end

  down do
    drop_column :planes, :precio
  end
end
