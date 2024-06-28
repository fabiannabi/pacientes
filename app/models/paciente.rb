class Paciente < ApplicationRecord
  # Validaciones de ejemplo
  validates :nombre, presence: true
  validates :apellido, presence: true
  validates :estado_civil, presence: true
  validates :grado_estudios, presence: true
  validates :ocupacion, presence: true
  validates :domicilio, presence: true
  validates :fecha_nacimiento, presence: true
  validates :procedencia, presence: true
  validates :sexo, presence: true
  validates :edad, presence: true

  # Otros métodos relacionados
end