# Service Objects Tutorial: Introduction
# Learn the service object pattern for organizing business logic

# Resources:
# - Service Objects in Rails: Search "Ruby service objects" on ruby-doc.org
# - Design patterns: https://refactoring.guru/design-patterns/ruby
# - Rails best practices: https://guides.rubyonrails.org/
# - Single Responsibility: Search "SOLID principles" for more context

# ============================================================================
# 1. WHAT IS A SERVICE OBJECT?
# ============================================================================

# A service object is a class that encapsulates a single business action.
# Instead of putting logic in controllers or models, you extract it into a service.

# Without service objects (logic scattered):
# def user_signup(email, password)
#   user = User.create(email: email, password: password)
#   send_welcome_email(user)
#   notify_admin(user)
#   log_signup(user)
# end

# With service objects (organized):
# UserSignupService.call(email, password)

# ============================================================================
# 2. THE BASIC PATTERN
# ============================================================================

# The service object pattern has a standard structure:

class WelcomeEmailService
  # 1. Class method: entry point (how users call the service)
  def self.call(user_email)
    new(user_email).call
  end

  # 2. Initialize: store data as instance variables
  def initialize(user_email)
    @email = user_email
  end

  # 3. Call method: the main action
  def call
    compose_message
    send_email
    true  # Return success
  end

  # 4. Private methods: helper logic using instance variables
  private

  def compose_message
    @subject = "Welcome!"
    @body = "Thanks for joining us, #{@email}!"
  end

  def send_email
    puts "Sending email to #{@email}"
    puts "Subject: #{@subject}"
    puts "Body: #{@body}"
  end
end

# Usage:
# WelcomeEmailService.call("paul@example.com")

# ============================================================================
# 3. WHY USE SERVICE OBJECTS?
# ============================================================================

# Before (procedural, hard to test and reuse):
def send_welcome_email(email, name, company)
  subject = "Welcome to #{company}!"
  body = "Hi #{name}, thanks for joining!"
  # ... send email logic
  puts "Sent to #{email}"
end

send_welcome_email("paul@example.com", "Paul", "Acme Corp")
send_welcome_email("jane@example.com", "Jane", "Acme Corp")

# After (object-oriented, easy to test and reuse):
class WelcomeEmailServiceV2
  def self.call(email, name, company)
    new(email, name, company).call
  end

  def initialize(email, name, company)
    @email = email
    @name = name
    @company = company
  end

  def call
    compose_message
    send_email
  end

  private

  def compose_message
    @subject = "Welcome to #{@company}!"
    @body = "Hi #{@name}, thanks for joining!"
  end

  def send_email
    puts "Sent to #{@email}"
  end
end

# Usage (same interface, better organized):
# WelcomeEmailServiceV2.call("paul@example.com", "Paul", "Acme Corp")
# WelcomeEmailServiceV2.call("jane@example.com", "Jane", "Acme Corp")

# ============================================================================
# 4. INSTANCE VARIABLES: THE KEY BENEFIT
# ============================================================================

# The power of service objects is sharing data across methods via @variables

class PaymentProcessingService
  def self.call(user_id, amount)
    new(user_id, amount).call
  end

  def initialize(user_id, amount)
    @user_id = user_id      # Stored once, used everywhere
    @amount = amount        # No need to pass around
  end

  def call
    validate_user
    validate_amount
    process_payment
    send_receipt
  end

  private

  # Every method can use @user_id and @amount
  def validate_user
    puts "Validating user #{@user_id}"
  end

  def validate_amount
    puts "Validating amount #{@amount}"
  end

  def process_payment
    puts "Processing $#{@amount} for user #{@user_id}"
  end

  def send_receipt
    puts "Sending receipt to user #{@user_id} for $#{@amount}"
  end
end

# Compare to passing parameters everywhere:
# def validate_user(user_id, amount, ...)
#   def validate_amount(user_id, amount, ...)
#     def process_payment(user_id, amount, ...)
# # Cleaner with service objects!

# ============================================================================
# 5. RETURN VALUES
# ============================================================================

# Service objects can return different things depending on success/failure

class SimpleAuthService
  def self.call(email, password)
    new(email, password).call
  end

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    return false if @email.empty?
    return false if @password.length < 8
    true  # Success
  end
end

# Usage:
# result = SimpleAuthService.call("paul@example.com", "password123")
# if result
#   puts "Login successful"
# else
#   puts "Login failed"
# end

# ============================================================================
# 6. PRACTICE: Build Your First Service Object
# ============================================================================

# A service to calculate and display invoice totals

class InvoiceTotalService
  def self.call(items, tax_rate = 0.1)
    new(items, tax_rate).call
  end

  def initialize(items, tax_rate)
    @items = items        # Array of prices
    @tax_rate = tax_rate
  end

  def call
    {
      subtotal: calculate_subtotal,
      tax: calculate_tax,
      total: calculate_total
    }
  end

  private

  def calculate_subtotal
    @items.sum
  end

  def calculate_tax
    calculate_subtotal * @tax_rate
  end

  def calculate_total
    calculate_subtotal + calculate_tax
  end
end

# Usage:
# items = [10.0, 20.0, 15.0]
# result = InvoiceTotalService.call(items, 0.1)
# puts result
# => {:subtotal=>45.0, :tax=>4.5, :total=>49.5}

# ============================================================================
# 7. TESTING SERVICE OBJECTS (Preview)
# ============================================================================

# Service objects are EASY to test because:
# 1. No external dependencies (usually)
# 2. Clear input (initialize params) and output (return value)
# 3. No side effects (usually)

# Example test (you'll learn RSpec in detail later):
# describe InvoiceTotalService do
#   it "calculates total with tax" do
#     result = InvoiceTotalService.call([10.0, 20.0], 0.1)
#     expect(result[:total]).to eq(33.0)
#   end
# end

# ============================================================================
# KEY CONCEPTS SUMMARY
# ============================================================================

# 1. Service object = class that does ONE thing
# 2. self.call = entry point (class method)
# 3. initialize = store data as @variables
# 4. call = main action (instance method)
# 5. private methods = helpers using @variables
# 6. Return value = result of the service (true/false, hash, object)
# 7. Benefits = reusable, testable, organized, single responsibility

# ============================================================================
# DESIGN PATTERNS COMPARISON
# ============================================================================

# Procedural (function-based):
# - Good for: simple one-off operations
# - Bad for: complex logic, reuse, testing

# Service object:
# - Good for: business logic, testability, reuse, clarity
# - Bad for: very simple operations (overkill)

# When to use service objects:
# ✓ Complex business logic (user signup, payment processing)
# ✓ Something you'll do in multiple places
# ✓ Something you want to test thoroughly
# ✗ Simple utility functions (use methods instead)

# ============================================================================
# PRACTICE EXERCISES
# ============================================================================

# 1. Create UserSignupService
#    - Takes email, password, name
#    - Validates all three (in private methods)
#    - Returns true if valid, false if not
#    - Test with valid and invalid inputs

# 2. Create EmailSendingService
#    - Takes recipient, subject, body
#    - Sends email (simulate with puts)
#    - Logs the send
#    - Returns true on success

# 3. Create PasswordValidationService
#    - Takes a password
#    - Checks: at least 8 chars, has number, has letter
#    - Returns hash with valid: true/false and errors: []
#    - Example: { valid: false, errors: ["Too short", "No number"] }

puts "\n✓ Service Objects intro complete. Ready for intermediate patterns!"
