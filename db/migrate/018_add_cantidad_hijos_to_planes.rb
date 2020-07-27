Sequel.migration do
  up do
    add_column :planes, :children, Integer, default: 0
  end

  down do
    drop_column :planes, :children
  end
end
