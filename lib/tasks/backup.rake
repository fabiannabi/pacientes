# lib/tasks/backup.rake
namespace :backup do
  desc "Exportar todos los registros de todas las tablas a archivos CSV"
  task export_all: :environment do
    require 'csv'

    # Asegúrate de que el directorio de backup existe
    backup_dir = Rails.root.join('backup')
    FileUtils.mkdir_p(backup_dir) unless File.directory?(backup_dir)

    # Obtener todas las tablas
    ActiveRecord::Base.connection.tables.each do |table_name|
      # Excluir tablas internas de Rails si es necesario
      next if ['schema_migrations', 'ar_internal_metadata'].include?(table_name)

      # Obtener todos los registros de la tabla
      records = ActiveRecord::Base.connection.execute("SELECT * FROM #{table_name}")

      # Obtener los nombres de las columnas de la tabla
      column_names = ActiveRecord::Base.connection.columns(table_name).map(&:name)

      # Ruta del archivo CSV
      file_path = backup_dir.join("#{table_name}.csv")

      # Crear y escribir en el archivo CSV
      CSV.open(file_path, 'w') do |csv|
        # Escribir encabezados
        csv << column_names

        # Escribir registros
        records.each do |row|
          csv << row.values
        end
      end

      puts "Registros de la tabla #{table_name} exportados a #{file_path}"
    end
  end
end
