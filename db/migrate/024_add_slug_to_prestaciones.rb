Sequel.migration do
  up do
    add_column :prestaciones, :slug, String
  end

  down do
    drop_column :prestaciones, :slug
  end
end
