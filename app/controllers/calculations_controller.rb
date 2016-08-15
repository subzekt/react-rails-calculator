class CalculationsController < ApplicationController
  def index
  end

  def calculate
    first_number = params[:first_number]
    second_number = params[:second_number]
    operation_type = params[:operation_type]

    # search the database for the identical operation
    # update the count if the operation is present else create a new one
    @calculation = Calculation.find_previous_calculation(first_number, second_number, operation_type)
    if @calculation.present?
      @calculation.request_count += 1
    else
      @calculation = Calculation.new(first_number: first_number, second_number: second_number, operation_type: operation_type)
    end

    if @calculation.save
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @calculation.response_data, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :index }
        format.json { render json: @calculation.response_data, status: :unprocessable_entity }
      end
    end


  end
end
