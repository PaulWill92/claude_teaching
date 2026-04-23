# Service Objects Tutorial: Advanced
# Service composition, orchestration, and complex workflows

# Resources:
# - Composition patterns: Search "Ruby composition over inheritance"
# - Dependency injection: Search "Ruby dependency injection patterns"
# - Service orchestration: Search "service orchestration Ruby"

# ============================================================================
# 1. COMPOSING SERVICES (Calling Other Services)
# ============================================================================

# One service can call other services to build complex workflows

class SendEmailService
  def self.call(recipient, subject, body)
    new(recipient, subject, body).call
  end

  def initialize(recipient, subject, body)
    @recipient = recipient
    @subject = subject
    @body = body
  end

  def call
    puts "Email sent to #{@recipient}: #{@subject}"
    true
  end
end

class CreateUserWithWelcomeService
  def self.call(email, password)
    new(email, password).call
  end

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    # Step 1: Create the user
    create_user
    return { success: false } unless user_created?

    # Step 2: Send welcome email (using another service!)
    SendEmailService.call(@email, "Welcome!", "Thanks for signing up!")

    # Step 3: Log the action
    log_signup

    { success: true, email: @email }
  end

  private

  def create_user
    puts "Creating user #{@email}"
  end

  def user_created?
    true
  end

  def log_signup
    puts "Logged signup for #{@email}"
  end
end

# Usage:
# result = CreateUserWithWelcomeService.call("paul@example.com", "password123")
# This service orchestrates: user creation + email + logging

# ============================================================================
# 2. SERVICE ORCHESTRATION (Conductor Pattern)
# ============================================================================

# A "conductor" service coordinates multiple services

class CheckoutService
  def self.call(order_id, user_id, payment_method)
    new(order_id, user_id, payment_method).call
  end

  def initialize(order_id, user_id, payment_method)
    @order_id = order_id
    @user_id = user_id
    @payment_method = payment_method
    @errors = []
  end

  def call
    # Coordinate multiple services
    validate_order
    return error_result unless valid?

    process_payment
    reduce_inventory
    send_confirmation_email
    notify_seller

    success_result
  end

  private

  def validate_order
    # Use ValidateOrderService
    puts "Validating order #{@order_id}"
  end

  def process_payment
    # Use ProcessPaymentService
    puts "Processing payment with #{@payment_method}"
  end

  def reduce_inventory
    # Use ReduceInventoryService
    puts "Reducing inventory for order #{@order_id}"
  end

  def send_confirmation_email
    # Use SendEmailService
    puts "Sending confirmation email to user #{@user_id}"
  end

  def notify_seller
    # Use NotifyService
    puts "Notifying seller of order #{@order_id}"
  end

  def valid?
    @errors.empty?
  end

  def success_result
    { success: true, order_id: @order_id, status: "completed" }
  end

  def error_result
    { success: false, errors: @errors }
  end
end

# Usage:
# result = CheckoutService.call(123, 456, "credit_card")
# One service coordinates the entire checkout workflow

# ============================================================================
# 3. DEPENDENCY INJECTION (Making Services Testable)
# ============================================================================

# Instead of hardcoding services, inject them as dependencies

class EmailGateway
  def send(recipient, subject, body)
    puts "Sending email to #{recipient}"
  end
end

class MockEmailGateway
  def send(recipient, subject, body)
    # For testing, do nothing
  end
end

class UserSignupService
  def self.call(email, password, email_gateway = EmailGateway.new)
    new(email, password, email_gateway).call
  end

  def initialize(email, password, email_gateway)
    @email = email
    @password = password
    @email_gateway = email_gateway  # Injected dependency
  end

  def call
    create_user
    send_welcome_email
    true
  end

  private

  def create_user
    puts "Creating user #{@email}"
  end

  def send_welcome_email
    # Use the injected gateway (could be real or mock)
    @email_gateway.send(@email, "Welcome!", "...")
  end
end

# Usage in production:
# UserSignupService.call("paul@example.com", "password123")
# => Uses real EmailGateway

# Usage in tests:
# UserSignupService.call("paul@example.com", "password123", MockEmailGateway.new)
# => Uses mock (doesn't actually send email)

# ============================================================================
# 4. CHAINING SERVICES WITH EARLY EXIT
# ============================================================================

# Services that call other services and stop on first failure

class PublishBlogPostService
  def self.call(post_id)
    new(post_id).call
  end

  def initialize(post_id)
    @post_id = post_id
  end

  def call
    # Each step checks if previous succeeded
    validate_post
    return failure("Post invalid") unless valid?

    optimize_images
    return failure("Image optimization failed") unless optimized?

    publish_post
    return failure("Publishing failed") unless published?

    notify_subscribers
    success
  end

  private

  def validate_post
    puts "Validating post #{@post_id}"
    @valid = true
  end

  def valid?
    @valid
  end

  def optimize_images
    puts "Optimizing images for post #{@post_id}"
    @optimized = true
  end

  def optimized?
    @optimized
  end

  def publish_post
    puts "Publishing post #{@post_id}"
    @published = true
  end

  def published?
    @published
  end

  def notify_subscribers
    puts "Notifying subscribers about post #{@post_id}"
  end

  def success
    { success: true, post_id: @post_id }
  end

  def failure(message)
    { success: false, error: message }
  end
end

# ============================================================================
# 5. SIDE EFFECTS AND TRANSACTIONS
# ============================================================================

# Service that manages multiple state changes atomically

class TransferMoneyWithRollbackService
  def self.call(from_id, to_id, amount)
    new(from_id, to_id, amount).call
  end

  def initialize(from_id, to_id, amount)
    @from_id = from_id
    @to_id = to_id
    @amount = amount
    @changes = []
  end

  def call
    begin
      deduct_from_sender
      @changes << { user: @from_id, type: "deduct", amount: @amount }

      add_to_receiver
      @changes << { user: @to_id, type: "add", amount: @amount }

      log_transaction
      @changes << { type: "log" }

      { success: true, changes: @changes }

    rescue StandardError => e
      # Rollback all changes if anything fails
      rollback
      { success: false, error: e.message }
    end
  end

  private

  def deduct_from_sender
    puts "Deducting $#{@amount} from user #{@from_id}"
    # Could raise if insufficient funds
  end

  def add_to_receiver
    puts "Adding $#{@amount} to user #{@to_id}"
    # Could raise if account locked
  end

  def log_transaction
    puts "Logging transaction"
    # Could raise if database unavailable
  end

  def rollback
    puts "Rolling back #{@changes.length} changes"
    @changes.each do |change|
      puts "Undoing: #{change}"
    end
  end
end

# ============================================================================
# 6. BUILDING A COMPLEX WORKFLOW
# ============================================================================

# Real-world example: Job application workflow

class ProcessJobApplicationService
  def self.call(application_id)
    new(application_id).call
  end

  def initialize(application_id)
    @application_id = application_id
    @application = { id: application_id, status: "pending" }
  end

  def call
    # Complex workflow with multiple steps
    load_application
    return error("Not found") unless application_exists?

    screen_resume
    return error("Resume rejected") unless passed_screening?

    run_background_check
    return error("Background check failed") unless passed_background?

    schedule_interview
    notify_candidate
    notify_hiring_team

    success
  end

  private

  def load_application
    puts "Loading application #{@application_id}"
  end

  def application_exists?
    !@application.nil?
  end

  def screen_resume
    puts "Screening resume for application #{@application_id}"
    @resume_score = 8  # Simulate scoring
  end

  def passed_screening?
    @resume_score >= 7
  end

  def run_background_check
    puts "Running background check"
    @background_passed = true
  end

  def passed_background?
    @background_passed
  end

  def schedule_interview
    puts "Scheduling interview"
  end

  def notify_candidate
    puts "Notifying candidate"
  end

  def notify_hiring_team
    puts "Notifying hiring team"
  end

  def success
    { success: true, next_step: "interview_scheduled" }
  end

  def error(message)
    { success: false, error: message }
  end
end

# ============================================================================
# 7. SERVICE CONFIGURATION (Making Services Flexible)
# ============================================================================

class ConfigurableEmailService
  def self.call(recipient, subject, body, config = {})
    new(recipient, subject, body, config).call
  end

  def initialize(recipient, subject, body, config = {})
    @recipient = recipient
    @subject = subject
    @body = body
    @config = {
      priority: :normal,
      retry_count: 3,
      template: :default
    }.merge(config)
  end

  def call
    apply_template
    send_with_retry
  end

  private

  def apply_template
    case @config[:template]
    when :html
      puts "Applying HTML template"
    when :plain
      puts "Applying plain text template"
    else
      puts "Applying default template"
    end
  end

  def send_with_retry
    retries = 0
    begin
      retries += 1
      send_email
      true
    rescue StandardError
      if retries < @config[:retry_count]
        sleep 1
        retry
      else
        false
      end
    end
  end

  def send_email
    puts "Sending #{@config[:priority]} email to #{@recipient}"
  end
end

# Usage:
# ConfigurableEmailService.call(
#   "paul@example.com",
#   "Welcome",
#   "Thanks!",
#   { priority: :high, template: :html, retry_count: 5 }
# )

# ============================================================================
# KEY CONCEPTS SUMMARY
# ============================================================================

# 1. Service composition = one service calls another
# 2. Conductor pattern = orchestrate multiple services
# 3. Dependency injection = pass dependencies in, not create them
# 4. Early exit = stop on first failure, return error
# 5. Transactions = rollback if anything fails
# 6. Complex workflows = coordinate multiple steps with clear flow
# 7. Configuration = make services flexible with options

# ============================================================================
# PRACTICE EXERCISES
# ============================================================================

# 1. Create a three-step service
#    - ValidateUserService (check user exists)
#    - UpdateProfileService (update user data)
#    - NotifyFollowersService (alert followers)
#    - All three composed in one UpdateUserProfileService
#    - Each step depends on previous success

# 2. Create a service with dependency injection
#    - NotificationService that can use email, SMS, or push
#    - Pass the "gateway" as a dependency
#    - Make it testable with mock gateways

# 3. Build a checkout workflow
#    - Validate cart, process payment, reduce inventory, send confirmation
#    - Rollback inventory if payment fails
#    - Return clear error messages

puts "\n✓ Service Objects advanced complete. You're ready for real-world Rails!"
