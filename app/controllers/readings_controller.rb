# frozen_string_literal: true

class ReadingsController < ApplicationController
  before_action :set_reading, only: %i[show edit update destroy]

  # GET /readings
  # GET /readings.json
  def index
    @readings = Reading.where(session_id: params[:session])
  end

  # GET /readings/1
  # GET /readings/1.json
  def show; end

  # GET /readings/new
  def new
    @reading = Reading.new(report_id: params['report'])
  end

  # GET /readings/1/edit
  def edit; end

  # POST /readings
  # POST /readings.json
  def create
    if readings_params.present?
      # Find all readings based on given params
      # Update all found readings in a transaction
      # Create new readings for all remaining params
      Reading.transaction do
        @readings = Reading.where(session_id: readings_params[:session_id].to_i, number: readings_params[:readings].map { |p| p [:number] }).map do |reading|
          reading.assign_attributes(readings_params[:readings].find {|p| p[:number].to_i == reading.number })
          reading
        end

        # Reject parameters which have a matching db record
        remaining = readings_params[:readings].reject { |p| @readings.map(&:number).include?(p[:number].to_i) }
        remaining.each do |param|
          @readings << Reading.new(param)
        end
        @readings.select(&:changed?).map &:save!
      end
    end

    respond_to do |format|
      if @reading.save
        format.html { redirect_to @reading, notice: 'Reading was successfully created.' }
        format.json { render :show, status: :created, location: @reading }
      else
        format.html { render :new }
        format.json { render json: @reading.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /readings/1
  # PATCH/PUT /readings/1.json
  def update
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
    @reading.destroy
    respond_to do |format|
      format.html { redirect_to readings_url, notice: 'Reading was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_reading
    @reading = Reading.find(params[:id])
  end

  def readings_params
    params.require(:reading).permit(:session_id, readings: [:session_id, :number, :readings, :car_class])
  end

  def reading_params
    params.require(:reading).permit(:number, :car_class, :readings)
  end
end
