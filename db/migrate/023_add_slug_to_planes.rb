Sequel.migration do
  up do
    add_column :planes, :slug, String
  end

  down do
    drop_column :planes, :slug
  end
end
