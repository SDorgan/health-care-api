Sequel.migration do
  up do
    add_column :planes, :medicine_coverage, Integer, default: 0
  end

  down do
    drop_column :planes, :medicine_coverage
  end
end
