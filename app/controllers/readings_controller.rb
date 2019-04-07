# frozen_string_literal: true

class ReadingsController < ApplicationController
  before_action :set_reading, only: %i[show edit update destroy]

  # GET /readings
  # GET /readings.json
  def index
    @readings = Reading.where(session_id: params[:session])
    authorize @readings
  end

  # GET /readings/1
  # GET /readings/1.json
  def show
    authorize Reading
  end

  # GET /readings/new
  def new
    @reading = Reading.new(session_id: params['session'])
    authorize @reading
  end

  # GET /readings/1/edit
  def edit
    authorize Reading
  end

  # POST /readings
  # POST /readings.json
  def create
    authorize Reading
    # TODO: REFACTOR: I think some of this can be moved to the model
    # Find all readings based on given params
    # Update all found readings in a transaction
    # Create new readings for all remaining params
    set_readings
    assing_reading_params
    create_objects_for_new_records
    reject_invalid
    select_valid
    @readings.map(&:save)

    respons(@rejected.empty?)
  end

  # PATCH/PUT /readings/1
  # PATCH/PUT /readings/1.json
  def update
    authorize @reading
    respond_to do |format|
      if @reading.update(reading_params)
        format.html { redirect_to @reading, notice: 'Reading was successfully updated.' }
        format.json { render :show, status: :ok, location: @reading }
      else
        format.html { render :edit }
        format.json { render json: @reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /readings/1
  # DELETE /readings/1.json
  def destroy
    authorize @reading
    @reading.destroy
    respond_to do |format|
      format.html { redirect_to readings_url, notice: 'Reading was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_session
    @session = Session.find(session_params[:id])
  end

  def session_params
    params.require(:session).permit(:id)
  end

  def set_readings
    reading_numbers = readings_params[:readings].map { |p| p [:number] }
    @readings = Reading.where(session: session_params[:id],
                              number: reading_numbers)
  end

  def assing_reading_params
    @readings = @readings.map do |reading|
      reading.assign_attributes(find_param_by_number(reading))
      reading
    end
  end

  def find_param_by_number(reading)
    readings_params[:readings].find do |p|
      p[:number].to_i == reading.number
    end
  end

  def set_reading
    @reading = Reading.find(params[:id])
  end

  def create_objects_for_new_records
    # Reject parameters which have a matching db record
    remaining = readings_params[:readings].reject do |p|
      @readings.map(&:number).include?(p[:number].to_i)
    end
    remaining.each do |param|
      @readings << Reading.new(param)
    end
  end

  def reject_invalid
    @rejected = @readings.reject(&:valid?)
  end

  def respons(success)
    respond_to do |format|
      if success
        format.json { render json: @readings, status: :created }
      else
        format.json do
          render json: @rejected.map(&:errors),
                 status: :unprocessable_entity
        end
      end
    end
  end

  def save_readings
    Reading.transaction do
      @valid_readings.map(&:save)
    end
  end

  def select_valid
    @valid_readings = @readings.select(&:changed?).select(&:valid?)
  end

  def readings_params
    params.require(:reading).permit(readings: %i[number
                                                 readings
                                                 car_class
                                                 session_id])
  end

  def reading_params
    params.require(:reading).permit(:number, :car_class, :readings)
  end
end
