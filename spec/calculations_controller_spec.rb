require_relative '../config/environment'
require 'rails_helper'

describe CalculationsController,  :type => :controller do

  it "should get result on valid data and insert into database" do

    # delete the data is previously setup
    Calculation.where(first_number: 12, second_number: 27, operation_type: 'addition').delete_all

    json = { :format => 'json', first_number: 12, second_number: 27, operation_type: 'addition' }
    get 'calculate', json
    # status should be ok
    expect(response.status).to eq 200
    calculations = Calculation.where(first_number: 12, second_number: 27, operation_type: 'addition')
    expect(calculations.count).to eq 1
    expect(calculations.first.request_count).to eq 1

    # upon firing same operation again the request count should increase
    # but the database entry should not be created again
    get 'calculate', json
    calculations = Calculation.where(first_number: 12, second_number: 27, operation_type: 'addition')
    expect(calculations.count).to eq 1
    expect(calculations.first.request_count).to eq 2
  end

  it "should get error on invalid first number" do
    # first number not present
    json = { :format => 'json', second_number: 27, operation_type: 'addition' }
    get 'calculate', json
    # status should be unprocessable entity
    expect(response.status).to eq 422
    expect(response.body).to eq "error"

    # first number 0
    json = { :format => 'json', first_number: 0, second_number: 27, operation_type: 'addition' }
    get 'calculate', json
    # status should be unprocessable entity
    expect(response.status).to eq 422
    expect(response.body).to eq "error"


    # first number negative
    json = { :format => 'json', first_number: -5, second_number: 27, operation_type: 'addition' }
    get 'calculate', json
    # status should be unprocessable entity
    expect(response.status).to eq 422
    expect(response.body).to eq "error"

    # first number greater than max allowed value
    json = { :format => 'json', first_number: 100, second_number: 27, operation_type: 'addition' }
    get 'calculate', json
    # status should be unprocessable entity
    expect(response.status).to eq 422
    expect(response.body).to eq "error"
  end

  it "should get error on invalid second number" do
    # second number not present
    json = { :format => 'json', first_number: 27, operation_type: 'addition' }
    get 'calculate', json
    # status should be unprocessable entity
    expect(response.status).to eq 422
    expect(response.body).to eq "error"

    # second number 0
    json = { :format => 'json', second_number: 0, first_number: 27, operation_type: 'addition' }
    get 'calculate', json
    # status should be unprocessable entity
    expect(response.status).to eq 422
    expect(response.body).to eq "error"


    # second number negative
    json = { :format => 'json', second_number: -5, first_number: 27, operation_type: 'addition' }
    get 'calculate', json
    # status should be unprocessable entity
    expect(response.status).to eq 422
    expect(response.body).to eq "error"

    # second number greater than max allowed value
    json = { :format => 'json', second_number: 100, first_number: 27, operation_type: 'addition' }
    get 'calculate', json
    # status should be unprocessable entity
    expect(response.status).to eq 422
    expect(response.body).to eq "error"
  end

  it "should get error on invalid operation type" do
    # add is not a valid operation type
    json = { :format => 'json', first_number: 27, second_number: 25, operation_type: 'add' }
    get 'calculate', json
    # status should be unprocessable entity
    expect(response.status).to eq 422
    expect(response.body).to eq "error"
  end

  it "should get result on addition" do
    json = { :format => 'json', first_number: 27, second_number: 25, operation_type: 'addition' }
    get 'calculate', json
    expect(response.status).to eq 200
    parsed_body = JSON.parse(response.body)
    expect(parsed_body["Result"]).to eq 52
    expect(parsed_body["Operation"]).to eq "27 + 25"
    expect(parsed_body["Count"]).to_not eq 0
    expect(parsed_body["ID"]).to_not eq nil
  end

  it "should get result on subtraction" do
    json = { :format => 'json', first_number: 27, second_number: 25, operation_type: 'subtraction' }
    get 'calculate', json
    expect(response.status).to eq 200
    parsed_body = JSON.parse(response.body)
    expect(parsed_body["Result"]).to eq 2
    expect(parsed_body["Operation"]).to eq "27 - 25"
    expect(parsed_body["Count"]).to_not eq 0
    expect(parsed_body["ID"]).to_not eq nil
  end

  it "should get result on multiplication" do
    json = { :format => 'json', first_number: 5, second_number: 5, operation_type: 'multiplication' }
    get 'calculate', json
    expect(response.status).to eq 200
    parsed_body = JSON.parse(response.body)
    expect(parsed_body["Result"]).to eq 25
    expect(parsed_body["Operation"]).to eq "5 * 5"
    expect(parsed_body["Count"]).to_not eq 0
    expect(parsed_body["ID"]).to_not eq nil
  end

  it "should get result on division" do
    json = { :format => 'json', first_number: 27, second_number: 3, operation_type: 'division' }
    get 'calculate', json
    expect(response.status).to eq 200
    parsed_body = JSON.parse(response.body)
    expect(parsed_body["Result"]).to eq 9
    expect(parsed_body["Operation"]).to eq "27 / 3"
    expect(parsed_body["Count"]).to_not eq 0
    expect(parsed_body["ID"]).to_not eq nil
  end


end