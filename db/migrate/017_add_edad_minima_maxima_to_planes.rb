Sequel.migration do
  up do
    add_column :planes, :minimum_age, Integer, default: 0
    add_column :planes, :maximum_age, Integer, default: 200
  end

  down do
    drop_column :planes, :minimum_age
    drop_column :planes, :maximum_age
  end
end
