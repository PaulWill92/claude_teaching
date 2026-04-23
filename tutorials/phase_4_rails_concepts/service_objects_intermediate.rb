# Service Objects Tutorial: Intermediate
# Error handling, validation, and return objects

# Resources:
# - Custom exceptions: Search "Ruby custom exception classes"
# - Result objects: Search "Service object result pattern"
# - Validation in Rails: https://guides.rubyonrails.org/active_record_validations.html

# ============================================================================
# 1. HANDLING ERRORS IN SERVICE OBJECTS
# ============================================================================

# Instead of returning true/false, return a result object

class CreateUserService
  def self.call(email, password)
    new(email, password).call
  end

  def initialize(email, password)
    @email = email
    @password = password
    @errors = []
  end

  def call
    validate_email
    validate_password
    return result unless @errors.empty?

    create_user
    result
  end

  private

  def validate_email
    if @email.nil? || @email.empty?
      @errors << "Email can't be blank"
    elsif !@email.include?("@")
      @errors << "Email must be valid"
    end
  end

  def validate_password
    if @password.nil? || @password.length < 8
      @errors << "Password must be at least 8 characters"
    end
  end

  def create_user
    puts "Creating user with #{@email}"
    # In real Rails: User.create(email: @email, password: @password)
  end

  def result
    {
      success: @errors.empty?,
      errors: @errors,
      email: @email
    }
  end
end

# Usage:
# result = CreateUserService.call("invalid", "short")
# puts result
# => { success: false, errors: ["Email must be valid", "Password must be at least 8 characters"] }

# result = CreateUserService.call("paul@example.com", "password123")
# puts result
# => { success: true, errors: [], email: "paul@example.com" }

# ============================================================================
# 2. CUSTOM RESULT OBJECTS
# ============================================================================

# Instead of returning hashes, create a Result class

class ServiceResult
  attr_reader :success, :errors, :data

  def initialize(success, errors = [], data = nil)
    @success = success
    @errors = errors
    @data = data
  end

  def success?
    @success
  end

  def failure?
    !@success
  end

  def error_message
    @errors.join(", ")
  end
end

class ProcessPaymentService
  def self.call(user_id, amount)
    new(user_id, amount).call
  end

  def initialize(user_id, amount)
    @user_id = user_id
    @amount = amount
  end

  def call
    validate_amount
    return error("Invalid amount") if @errors.any?

    process_payment
    success("Payment processed", { transaction_id: 12345 })
  end

  private

  def validate_amount
    @errors = []
    @errors << "Amount must be positive" if @amount <= 0
  end

  def process_payment
    puts "Processing $#{@amount} for user #{@user_id}"
  end

  def success(message, data = {})
    ServiceResult.new(true, [], data)
  end

  def error(message)
    ServiceResult.new(false, [message])
  end
end

# Usage:
# result = ProcessPaymentService.call(123, 50.0)
# if result.success?
#   puts "Payment successful!"
#   puts result.data  # {:transaction_id => 12345}
# else
#   puts "Failed: #{result.error_message}"
# end

# ============================================================================
# 3. RAISING CUSTOM EXCEPTIONS
# ============================================================================

# Define custom exceptions for different error types

class InvalidEmailError < StandardError; end
class InsufficientFundsError < StandardError; end

class WithdrawFundsService
  def self.call(user_id, amount)
    new(user_id, amount).call
  end

  def initialize(user_id, amount)
    @user_id = user_id
    @amount = amount
    @user_balance = 1000.0  # Simulate database
  end

  def call
    validate
    withdraw
    true
  end

  private

  def validate
    raise InsufficientFundsError, "Account only has $#{@user_balance}" if @amount > @user_balance
  end

  def withdraw
    puts "Withdrawing $#{@amount} for user #{@user_id}"
  end
end

# Usage:
# begin
#   WithdrawFundsService.call(123, 500)
# rescue InsufficientFundsError => e
#   puts "Error: #{e.message}"
# end

# ============================================================================
# 4. CHAINING VALIDATIONS
# ============================================================================

class ComplexSignupService
  def self.call(email, password, name)
    new(email, password, name).call
  end

  def initialize(email, password, name)
    @email = email
    @password = password
    @name = name
    @errors = []
  end

  def call
    validate_all
    return result unless valid?

    create_account
    send_welcome_email
    notify_admin

    result
  end

  private

  def validate_all
    validate_email
    validate_password
    validate_name
  end

  def validate_email
    if @email.empty?
      @errors << "Email required"
    elsif !@email.include?("@")
      @errors << "Email invalid"
    elsif email_exists?
      @errors << "Email already registered"
    end
  end

  def validate_password
    if @password.length < 8
      @errors << "Password too short"
    elsif !has_number?(@password)
      @errors << "Password needs a number"
    elsif !has_letter?(@password)
      @errors << "Password needs a letter"
    end
  end

  def validate_name
    if @name.empty?
      @errors << "Name required"
    elsif @name.length < 2
      @errors << "Name too short"
    end
  end

  def valid?
    @errors.empty?
  end

  def email_exists?
    # Simulate checking database
    false
  end

  def has_number?(str)
    str.match?(/\d/)
  end

  def has_letter?(str)
    str.match?(/[a-z]/i)
  end

  def create_account
    puts "Creating account for #{@email}"
  end

  def send_welcome_email
    puts "Sending welcome email to #{@email}"
  end

  def notify_admin
    puts "Notifying admin of new signup: #{@name}"
  end

  def result
    {
      success: valid?,
      errors: @errors
    }
  end
end

# Usage:
# result = ComplexSignupService.call("paul@example.com", "password123", "Paul")
# puts result

# ============================================================================
# 5. OPTIONAL PARAMETERS AND DEFAULTS
# ============================================================================

class SendNotificationService
  def self.call(user_id, message, priority: :normal, retry_count: 3)
    new(user_id, message, priority, retry_count).call
  end

  def initialize(user_id, message, priority = :normal, retry_count = 3)
    @user_id = user_id
    @message = message
    @priority = priority
    @retry_count = retry_count
  end

  def call
    send_with_retry
  end

  private

  def send_with_retry
    attempts = 0

    begin
      attempts += 1
      send_notification
      true
    rescue StandardError => e
      if attempts < @retry_count
        puts "Attempt #{attempts} failed, retrying..."
        sleep 1
        retry
      else
        puts "Failed after #{@retry_count} attempts"
        false
      end
    end
  end

  def send_notification
    puts "Sending #{@priority} notification to user #{@user_id}: #{@message}"
  end
end

# Usage:
# SendNotificationService.call(123, "Your order shipped")
# SendNotificationService.call(123, "Urgent alert", priority: :high, retry_count: 5)

# ============================================================================
# 6. PRACTICE: Build an Intermediate Service
# ============================================================================

class TransferMoneyService
  def self.call(from_user_id, to_user_id, amount)
    new(from_user_id, to_user_id, amount).call
  end

  def initialize(from_user_id, to_user_id, amount)
    @from_user_id = from_user_id
    @to_user_id = to_user_id
    @amount = amount
    @errors = []
  end

  def call
    validate
    return error_result unless valid?

    deduct_from_sender
    add_to_receiver
    log_transaction

    success_result
  end

  private

  def validate
    validate_users_different
    validate_amount_positive
    validate_sender_has_funds
  end

  def validate_users_different
    if @from_user_id == @to_user_id
      @errors << "Cannot transfer to yourself"
    end
  end

  def validate_amount_positive
    if @amount <= 0
      @errors << "Amount must be positive"
    end
  end

  def validate_sender_has_funds
    # Simulate database check
    sender_balance = 500.0
    if @amount > sender_balance
      @errors << "Insufficient funds"
    end
  end

  def valid?
    @errors.empty?
  end

  def deduct_from_sender
    puts "Deducting $#{@amount} from user #{@from_user_id}"
  end

  def add_to_receiver
    puts "Adding $#{@amount} to user #{@to_user_id}"
  end

  def log_transaction
    puts "Logged transfer: #{@from_user_id} -> #{@to_user_id}: $#{@amount}"
  end

  def success_result
    { success: true, transaction_id: 999 }
  end

  def error_result
    { success: false, errors: @errors }
  end
end

# ============================================================================
# KEY CONCEPTS SUMMARY
# ============================================================================

# 1. Result object = better than true/false (contains error details)
# 2. ServiceResult class = encapsulates success/failure/data
# 3. Custom exceptions = specific error types for rescue blocks
# 4. Validate early = fail fast, before making changes
# 5. Chain validations = collect all errors, show to user
# 6. Retry logic = handle transient failures
# 7. Optional params = use keyword arguments (priority: :normal)

# ============================================================================
# PRACTICE EXERCISES
# ============================================================================

# 1. Create UpdateProfileService
#    - Takes user_id, name, bio, email
#    - Validates all fields
#    - Returns ServiceResult with errors or success
#    - Updates "database" (simulate)

# 2. Create SendEmailService with retry
#    - Takes recipient, subject, body
#    - Validates recipient is email
#    - Sends with automatic retry (3 attempts)
#    - Returns result

# 3. Create ApplyDiscountService
#    - Takes order_id, discount_code
#    - Validates discount code exists
#    - Validates not already applied
#    - Calculates new total
#    - Returns ServiceResult with new_total

puts "\n✓ Service Objects intermediate complete. Ready for advanced patterns!"
