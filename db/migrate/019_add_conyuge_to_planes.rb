Sequel.migration do
  up do
    add_column :planes, :spouse, Integer, default: 0
  end

  down do
    drop_column :planes, :spouse
  end
end
