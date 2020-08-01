Sequel.migration do
  up do
    add_column :centros, :slug, String
  end

  down do
    drop_column :centros, :slug
  end
end
