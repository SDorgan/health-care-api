Sequel.migration do
  up do
    add_column :centros, :latitude, BigDecimal
    add_column :centros, :longitude, BigDecimal
  end

  down do
    drop_column :centros, :latitude
    drop_column :centros, :longitude
  end
end
