Sequel.migration do
  up do
    add_column :centros, :latitude, Float
    add_column :centros, :longitude, Float
  end

  down do
    drop_column :centros, :latitude
    drop_column :centros, :longitude
  end
end
