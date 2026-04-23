# Service Objects Practice Scenarios
# Apply service object patterns to realistic problems

# ============================================================================
# SCENARIO 1: Simple Service (Book Checkout)
# ============================================================================

# Requirements:
# - User checks out a book
# - Check book is available
# - Reduce inventory
# - Create checkout record
# - Return checkout details

class CheckoutBookService
  def self.call(user_id, book_id)
    new(user_id, book_id).call
  end

  def initialize(user_id, book_id)
    @user_id = user_id
    @book_id = book_id
    @book_inventory = 5  # Simulate database
  end

  def call
    return error("Book not available") if @book_inventory <= 0

    reduce_inventory
    create_checkout_record

    success
  end

  private

  def reduce_inventory
    @book_inventory -= 1
    puts "Reduced inventory. Remaining: #{@book_inventory}"
  end

  def create_checkout_record
    puts "Created checkout for user #{@user_id}, book #{@book_id}"
  end

  def success
    { success: true, due_date: "2 weeks" }
  end

  def error(message)
    { success: false, error: message }
  end
end

# Try it:
# result = CheckoutBookService.call(1, 100)
# puts result

# ============================================================================
# SCENARIO 2: Validation Service (Password Reset)
# ============================================================================

# Requirements:
# - Validate reset token
# - Validate new password strength
# - Update password
# - Send confirmation email
# - Log the change

class ResetPasswordService
  def self.call(token, new_password)
    new(token, new_password).call
  end

  def initialize(token, new_password)
    @token = token
    @new_password = new_password
    @errors = []
  end

  def call
    validate_token
    validate_password

    return error_result unless valid?

    update_password
    send_confirmation
    log_action

    success_result
  end

  private

  def validate_token
    # Simulate: check token exists and not expired
    token_valid = @token.length > 10
    @errors << "Invalid or expired token" unless token_valid
  end

  def validate_password
    if @new_password.length < 8
      @errors << "Password must be 8+ characters"
    elsif !has_number?(@new_password)
      @errors << "Password must contain a number"
    elsif !has_uppercase?(@new_password)
      @errors << "Password must contain uppercase letter"
    end
  end

  def has_number?(str)
    str.match?(/\d/)
  end

  def has_uppercase?(str)
    str.match?(/[A-Z]/)
  end

  def valid?
    @errors.empty?
  end

  def update_password
    puts "Updated password"
  end

  def send_confirmation
    puts "Sent confirmation email"
  end

  def log_action
    puts "Logged password change"
  end

  def success_result
    { success: true }
  end

  def error_result
    { success: false, errors: @errors }
  end
end

# Try it:
# result = ResetPasswordService.call("token123", "NewPassword1")
# puts result

# ============================================================================
# SCENARIO 3: Multi-Step Service (Product Purchase)
# ============================================================================

# Requirements:
# - Validate customer
# - Check inventory
# - Apply discount if applicable
# - Process payment
# - Send order confirmation

class PurchaseProductService
  def self.call(customer_id, product_id, quantity, discount_code = nil)
    new(customer_id, product_id, quantity, discount_code).call
  end

  def initialize(customer_id, product_id, quantity, discount_code)
    @customer_id = customer_id
    @product_id = product_id
    @quantity = quantity
    @discount_code = discount_code
    @errors = []
    @price = 29.99
    @discount_percent = 0
  end

  def call
    validate_customer
    return error_result unless valid?

    check_inventory
    return error_result unless valid?

    apply_discount if @discount_code
    calculate_total

    process_payment
    create_order
    send_confirmation

    success_result
  end

  private

  def validate_customer
    customer_exists = @customer_id > 0
    @errors << "Customer not found" unless customer_exists
  end

  def check_inventory
    # Simulate: 100 units available
    @errors << "Not enough inventory" if @quantity > 100
  end

  def apply_discount
    # Simulate: SAVE20 = 20% off
    if @discount_code == "SAVE20"
      @discount_percent = 20
    else
      @errors << "Invalid discount code"
    end
  end

  def calculate_total
    subtotal = @price * @quantity
    discount = subtotal * (@discount_percent / 100.0)
    @total = subtotal - discount
    puts "Total: $#{@total.round(2)}"
  end

  def process_payment
    puts "Processing payment of $#{@total.round(2)}"
  end

  def create_order
    puts "Creating order for customer #{@customer_id}"
  end

  def send_confirmation
    puts "Sending confirmation email"
  end

  def valid?
    @errors.empty?
  end

  def success_result
    { success: true, total: @total.round(2), order_id: 999 }
  end

  def error_result
    { success: false, errors: @errors }
  end
end

# Try it:
# result = PurchaseProductService.call(123, 1, 2, "SAVE20")
# puts result

# ============================================================================
# SCENARIO 4: Service Composition (Complete User Onboarding)
# ============================================================================

# Services that this calls:
# - CreateUserService
# - SendWelcomeEmailService
# - CreateDefaultPreferencesService
# - LogAnalyticsService

class OnboardUserService
  def self.call(email, password, name)
    new(email, password, name).call
  end

  def initialize(email, password, name)
    @email = email
    @password = password
    @name = name
  end

  def call
    create_user
    return error("User creation failed") unless user_created?

    send_welcome_email
    create_preferences
    log_signup

    success
  end

  private

  def create_user
    # This would call CreateUserService
    puts "Creating user #{@email}"
    @user_created = true
  end

  def user_created?
    @user_created
  end

  def send_welcome_email
    # This would call SendWelcomeEmailService
    puts "Sending welcome email to #{@email}"
  end

  def create_preferences
    # This would call CreateDefaultPreferencesService
    puts "Creating default preferences for #{@email}"
  end

  def log_signup
    # This would call LogAnalyticsService
    puts "Logging signup event for #{@email}"
  end

  def success
    { success: true, user_email: @email, message: "Welcome aboard!" }
  end

  def error(message)
    { success: false, error: message }
  end
end

# Try it:
# result = OnboardUserService.call("paul@example.com", "password123", "Paul")
# puts result

# ============================================================================
# SCENARIO 5: Service with Retry Logic (API Integration)
# ============================================================================

# Requirements:
# - Call external API
# - Retry on failure
# - Log attempts
# - Return data or error

class FetchWeatherService
  def self.call(city, retries = 3)
    new(city, retries).call
  end

  def initialize(city, retries)
    @city = city
    @max_retries = retries
    @attempts = 0
  end

  def call
    fetch_with_retry
  end

  private

  def fetch_with_retry
    begin
      @attempts += 1
      fetch_from_api

    rescue StandardError => e
      if @attempts < @max_retries
        puts "Attempt #{@attempts} failed. Retrying..."
        sleep 1
        retry
      else
        error("Failed after #{@max_retries} attempts: #{e.message}")
      end
    end
  end

  def fetch_from_api
    # Simulate API call that might fail
    # In real life: HTTParty.get("https://api.weather.com/...")
    puts "Fetching weather for #{@city}"

    # Simulate random failure
    if rand > 0.3
      success({ temp: 72, condition: "Sunny" })
    else
      raise "API temporarily unavailable"
    end
  end

  def success(data)
    { success: true, data: data }
  end

  def error(message)
    { success: false, error: message }
  end
end

# Try it:
# result = FetchWeatherService.call("San Francisco", 3)
# puts result

# ============================================================================
# SCENARIO 6: Service with Dependency Injection (Testable Notification)
# ============================================================================

class EmailSender
  def send(recipient, subject, body)
    puts "Sending real email to #{recipient}"
  end
end

class MockEmailSender
  def send(recipient, subject, body)
    # For testing, do nothing
  end
end

class SendNotificationService
  def self.call(user_id, message, sender = EmailSender.new)
    new(user_id, message, sender).call
  end

  def initialize(user_id, message, sender)
    @user_id = user_id
    @message = message
    @sender = sender  # Dependency injected
  end

  def call
    validate_user
    return error unless user_valid?

    @sender.send(@user_id, "Notification", @message)
    log_notification

    success
  end

  private

  def validate_user
    @user_valid = @user_id > 0
  end

  def user_valid?
    @user_valid
  end

  def log_notification
    puts "Logged notification"
  end

  def success
    { success: true }
  end

  def error
    { success: false, error: "Invalid user" }
  end
end

# Try in production:
# SendNotificationService.call(123, "Your order shipped")

# Try in test:
# SendNotificationService.call(123, "Your order shipped", MockEmailSender.new)

# ============================================================================
# CHALLENGE: Build Your Own Service
# ============================================================================

# Create a BookRecommendationService that:
# 1. Takes a user_id and genre preference
# 2. Validates user exists
# 3. Fetches recommended books from "database"
# 4. Ranks by rating
# 5. Returns top 5
# 6. Logs the recommendation request
#
# Use the pattern from Scenario 3 or 4

# ============================================================================
# PROGRESSION SUMMARY
# ============================================================================

# Scenario 1: Basic service (single action)
# Scenario 2: Service with validation
# Scenario 3: Multi-step service (orchestration)
# Scenario 4: Composing services
# Scenario 5: Retry logic
# Scenario 6: Dependency injection (testability)

puts "\n✓ Service Objects practice complete!"
