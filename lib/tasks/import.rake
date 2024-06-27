# lib/tasks/import.rake
namespace :backup do
  desc "Importar registros de archivos CSV a la base de datos"
  task import_all: :environment do
    require 'csv'

    # Directorio donde están los archivos CSV
    backup_dir = Rails.root.join('backup')

    # Verificar que el directorio de backup existe
    unless File.directory?(backup_dir)
      puts "El directorio de backup no existe"
      next
    end

    # Obtener la lista de archivos CSV en el directorio de backup
    Dir.glob(backup_dir.join('*.csv')).each do |file_path|
      table_name = File.basename(file_path, '.csv')
      puts "Importando tabla: #{table_name}"

      # Leer el archivo CSV y obtener los nombres de las columnas
      CSV.foreach(file_path, headers: true) do |row|
        begin
          # Crear un nuevo registro en la tabla correspondiente
          ActiveRecord::Base.connection.execute("INSERT INTO #{table_name} (#{row.headers.join(', ')}) VALUES (#{row.fields.map { |field| ActiveRecord::Base.connection.quote(field) }.join(', ')})")
        rescue => e
          puts "Error al importar fila: #{row.inspect}, error: #{e.message}"
        end
      end
      puts "Registros de la tabla #{table_name} importados desde #{file_path}"
    end
  end
end
