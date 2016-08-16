# calculations.rb
require_relative '../config/environment'
require 'rails_helper'
describe "Calculation Tests" do

  it "is valid with valid attributes" do
    calculation = Calculation.new(first_number: 1, second_number: 2, operation_type: 'addition')
    expect(calculation).to be_valid
  end


  it "is not valid without a first number" do
    calculation = Calculation.new(second_number: 2, operation_type: 'addition')
    expect(calculation).to_not be_valid
  end

  it "is not valid without a second number" do
    calculation = Calculation.new(first_number: 1, operation_type: 'addition')
    expect(calculation).to_not be_valid
  end

  it "is not valid without a non negative first number less than 100 and non integer"  do
    # first number negative
    calculation = Calculation.new(first_number: -1, second_number: 2, operation_type: 'addition')
    expect(calculation).to_not be_valid

    # first number 0
    calculation = Calculation.new(first_number: 0, second_number: 2, operation_type: 'addition')
    expect(calculation).to_not be_valid

    # first number 100
    calculation = Calculation.new(first_number: 100, second_number: 2, operation_type: 'addition')
    expect(calculation).to_not be_valid
  end

  it "is not valid without a non negative second number less than 100 and non integer"  do
    # second number less than max allowed value
    calculation = Calculation.new(first_number: 1, second_number: 0, operation_type: 'addition')
    expect(calculation).to_not be_valid
    # second number greater than max allowed value
    calculation = Calculation.new(first_number: 1, second_number: 100, operation_type: 'addition')
    expect(calculation).to_not be_valid

    # second number negative
    calculation = Calculation.new(first_number: 1, second_number: -5, operation_type: 'addition')
    expect(calculation).to_not be_valid

  end


  it "is not valid without a operation type" do
    calculation = Calculation.new(first_number: 1, second_number: 2)
    expect(calculation).to_not be_valid
  end

  it "is not valid without a valid operation type" do
    calculation = Calculation.new(first_number: 1, second_number: 2, operation_type: 'add')
    expect(calculation).to_not be_valid
  end

  # validate basic operation
  it "is valid with valid operation type and returns correct result" do
    # addition is valid operation type
    calculation = Calculation.new(first_number: 1, second_number: 2, operation_type: 'addition')
    expect(calculation).to be_valid
    calculation.save
    expect(calculation.result).to eq 3

    # subtraction is valid operation type
    calculation = Calculation.new(first_number: 1, second_number: 2, operation_type: 'subtraction')
    expect(calculation).to be_valid
    calculation.save
    expect(calculation.result).to eq -1

    # multiplication is valid operation type
    calculation = Calculation.new(first_number: 1, second_number: 2, operation_type: 'multiplication')
    expect(calculation).to be_valid
    calculation.save
    expect(calculation.result).to eq 2

    # division is valid operation type
    calculation = Calculation.new(first_number: 1, second_number: 2, operation_type: 'division')
    expect(calculation).to be_valid
    calculation.save
    expect(calculation.result).to eq 0.5
  end

end