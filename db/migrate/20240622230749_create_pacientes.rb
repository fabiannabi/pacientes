class CreatePacientes < ActiveRecord::Migration[7.1]
  def change
    create_table :pacientes do |t|
      t.string :nombre
      t.integer :edad
      t.string :sexo

      t.timestamps
    end
  end
end
