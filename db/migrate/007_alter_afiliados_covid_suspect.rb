Sequel.migration do
  up do
    add_column :afiliados, :covid_suspect, TrueClass, default: false
  end

  down do
    drop_column :afiliados, :covid_suspect
  end
end
