class PacientesController < ApplicationController
  before_action :set_paciente, only: [:show, :update, :destroy]

  # GET /pacientes
  def index
    @pacientes = Paciente.all
    render json: @pacientes
  end

  # GET /pacientes/1
  def show
    render json: @paciente
  end

  # POST /pacientes
 def create
  debugger
    @paciente = Paciente.new(paciente_params)
    # Validación adicional para asegurar que 'edad' sea un número
    # Validación adicional para asegurar que 'fecha_nacimiento' sea una fecha válida
    begin
      Date.parse(params[:fecha_nacimiento])
    rescue ArgumentError
      return render json: { error: 'Fecha de nacimiento no válida' }, status: :unprocessable_entity
    end

    if @paciente.save
      render json: @paciente, status: :created, location: @paciente
    else
      render json: @paciente.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pacientes/1
  def update
    if @paciente.update(paciente_params)
      render json: @paciente
    else
      render json: @paciente.errors, status: :unprocessable_entity
    end
  end

  # DELETE /pacientes/1
  def destroy
    @paciente.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paciente
      @paciente = Paciente.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def paciente_params
      params.require(:paciente).permit(:nombre, :edad, :sexo, :apellido, :estado_civil, :grado_estudios, :ocupacion, :domicilio, :fecha_nacimiento, :procedencia)
    end
end