class Calculation
  include Mongoid::Document

  ##########################################
  # Callbacks
  before_save :process_data

  ##########################################
  # Fields
  field :first_number, type: Integer
  field :second_number, type: Integer
  field :operation_type, type: String
  field :result, type: Float
  field :request_count, type: Integer, default: 1


  ##########################################
  # Constants
  OPERATIONS = %w(addition subtraction multiplication division).freeze

  ##########################################
  # Validations
  validates_inclusion_of :operation_type, in: OPERATIONS
  validates_presence_of :first_number, :second_number, :operation_type



  ########################################
  # Methods

  # search and find if the same calculation was performed earlier
  def self.find_previous_calculation(first_number, second_number, operation_type)
    # for the case of addition the positioning of the numbers do not matter
    # as 1+2 = 2+1
    if operation_type == 'addition'
      Calculation.any_of({first_number: first_number, second_number: second_number},{second_number: first_number, first_number: second_number}).where(operation_type: operation_type).first
    else
      Calculation.where(first_number: first_number, second_number: second_number,operation_type: operation_type).first
    end
  end

  # basic methods for the operations
  def divide
    self.first_number.to_f / self.second_number.to_f if self.valid?
  end

  def add
    self.first_number + self.second_number if self.valid?
  end

  def multiply
    self.first_number * self.second_number if self.valid?
  end

  def subtract
    self.first_number - self.second_number if self.valid?
  end



  # perform the calculation based on the operation type specified
  def process_data
    if self.valid? && self.result.blank?
      case self.operation_type
        when "addition"
          self.result = self.add
        when "subtraction"
          self.result = self.subtract
        when "multiplication"
          self.result = self.multiply
        when "division"
          self.result = self.divide
      end
    end
    self.result
  end

  def operation_symbol
    case self.operation_type
      when "addition"
        "+"
      when "subtraction"
        "-"
      when "multiplication"
        "*"
      when "division"
        "/"
    end
  end

  # formatted response data
  def response_data
    {
        :Operation => "#{self.first_number} #{self.operation_symbol} #{self.second_number}",
        :Result => self.result,
        :ID => self._id.to_s,
        :Count => self.request_count
    }
  end
end