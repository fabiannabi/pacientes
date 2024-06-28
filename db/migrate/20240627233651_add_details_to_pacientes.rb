class AddDetailsToPacientes < ActiveRecord::Migration[6.1]
  def change
    change_table :pacientes do |t|
      t.string :apellido
      t.string :estado_civil
      t.string :grado_estudios
      t.string :ocupacion
      t.string :domicilio, default: 'Aguascalientes'
      t.date :fecha_nacimiento
      t.string :procedencia
    end

    # Renombrar la columna 'nombre' a 'nombre'
    rename_column :pacientes, :nombre, :nombre

    # Dividir nombre completo en 'nombre' y 'apellido' puede necesitar un proceso manual o un script de datos aparte
  end
end
