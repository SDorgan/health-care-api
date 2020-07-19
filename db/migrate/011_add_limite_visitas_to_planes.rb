Sequel.migration do
  up do
    add_column :planes, :visit_limit, Integer, default: 0
  end

  down do
    drop_column :planes, :visit_limit
  end
end
