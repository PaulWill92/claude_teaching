# Error Handling Tutorial: Managing Failures Gracefully
# Learn how to catch and handle errors (like try/except in Python)

# Resources:
# - Exception handling: https://ruby-doc.org/core/Exception.html
# - Begin/rescue/ensure: Search "Ruby begin rescue ensure" on ruby-doc.org
# - Custom exceptions: Search "Ruby custom exception" on ruby-doc.org
# - Error types: Search "Ruby StandardError" on ruby-doc.org

# ============================================================================
# 1. BASIC TRY/CATCH (begin/rescue/end)
# ============================================================================

# Python:
# try:
#     result = 10 / 0
# except ZeroDivisionError:
#     print("Can't divide by zero")

# Ruby:
begin
  result = 10 / 0  # This raises an error
rescue ZeroDivisionError
  puts "Can't divide by zero"
end

# Multiple rescue blocks for different errors
begin
  # Some code
rescue ZeroDivisionError
  puts "Math error"
rescue ArgumentError
  puts "Wrong argument"
rescue StandardError
  puts "Generic error"
end

# ============================================================================
# 2. ACCESSING ERROR INFORMATION
# ============================================================================

begin
  1 / 0
rescue ZeroDivisionError => e
  puts "Error class: #{e.class}"
  puts "Error message: #{e.message}"
  puts "Backtrace: #{e.backtrace.first(3)}"
end

# => variable captures the error object
# .class = type of error
# .message = error description
# .backtrace = stack trace

# ============================================================================
# 3. ENSURE (Finally Block)
# ============================================================================

# Python:
# try:
#     ...
# except:
#     ...
# finally:
#     cleanup()

# Ruby:
begin
  file = File.open('data.txt')
  data = file.read

rescue FileNotFoundError
  puts "File not found"

ensure
  file.close if file  # Always runs, even if error
  puts "Cleanup done"
end

# ensure = runs no matter what (success or error)
# Useful for closing files, cleaning up resources

# ============================================================================
# 4. RAISING ERRORS
# ============================================================================

def divide(a, b)
  if b == 0
    raise ZeroDivisionError, "Cannot divide by zero"  # Custom message
  end
  a / b
end

begin
  result = divide(10, 0)
rescue ZeroDivisionError => e
  puts "Error: #{e.message}"
end

# raise = throw an exception
# format: raise ErrorType, "message"

# ============================================================================
# 5. CUSTOM EXCEPTIONS
# ============================================================================

# Define your own error types
class InvalidEmailError < StandardError
end

class UserNotFoundError < StandardError
end

def validate_email(email)
  unless email.include?("@")
    raise InvalidEmailError, "Email must include @"
  end
  email
end

begin
  validate_email("bad-email")
rescue InvalidEmailError => e
  puts "Validation failed: #{e.message}"
end

# Create custom errors by inheriting from StandardError
# Search "Ruby custom exception" for more patterns

# ============================================================================
# 6. RETRYING FAILED OPERATIONS
# ============================================================================

require 'openuri'

def fetch_with_retry(url, max_retries = 3)
  attempts = 0

  begin
    attempts += 1
    URI.open(url).read

  rescue OpenURI::HTTPError => e
    if attempts < max_retries
      puts "Attempt #{attempts} failed, retrying..."
      sleep 1
      retry  # Jump back to begin
    else
      puts "Failed after #{max_retries} attempts"
      raise
    end
  end
end

# retry = start the begin block again
# Useful for network operations that might succeed next time

# ============================================================================
# 7. RESCUE MODIFIERS (One-line rescue)
# ============================================================================

# Instead of:
def safe_divide_long(a, b)
  begin
    a / b
  rescue ZeroDivisionError
    0
  end
end

# Short form:
def safe_divide(a, b)
  a / b rescue 0
end

# result = risky_operation rescue default_value

# Only use for simple cases

# ============================================================================
# 8. COMMON ERROR TYPES
# ============================================================================

# StandardError (most common)
# - ZeroDivisionError (math error)
# - ArgumentError (wrong arguments)
# - FileNotFoundError (file missing)
# - TypeError (wrong type)
# - NameError (undefined variable)

# IOError (file operations)
# - FileNotFoundError (subclass of IOError)
# - PermissionError (can't access)

# NetworkError
# - SocketError (network problem)
# - OpenURI::HTTPError (HTTP problem)

# RuntimeError (generic runtime error)

# Search "Ruby error types" on ruby-doc.org for full list

# ============================================================================
# 9. PRACTICE: Safe Parser Class
# ============================================================================

require 'openuri'
require 'nokogiri'

class SafeScraper
  attr_reader :url, :doc, :error

  def initialize(url)
    @url = url
    @doc = nil
    @error = nil
  end

  def scrape
    begin
      html = URI.open(@url).read
      @doc = Nokogiri::HTML(html)
      true

    rescue OpenURI::HTTPError => e
      @error = "HTTP Error: #{e.message}"
      false

    rescue SocketError => e
      @error = "Network Error: #{e.message}"
      false

    rescue Nokogiri::XML::SyntaxError => e
      @error = "Parse Error: #{e.message}"
      false

    rescue StandardError => e
      @error = "Unexpected Error: #{e.message}"
      false

    ensure
      puts "Scrape attempt finished"
    end
  end

  def success?
    @error.nil?
  end

  def extract_titles
    if @doc.nil?
      puts "Error: #{@error}"
      return []
    end

    @doc.css('h1, h2').map(&:text)
  end
end

# Usage:
# scraper = SafeScraper.new('https://example.com')
# if scraper.scrape
#   puts scraper.extract_titles
# else
#   puts "Failed: #{scraper.error}"
# end

# ============================================================================
# 10. BEST PRACTICES
# ============================================================================

# DO:
# 1. Rescue specific errors, not all errors
# 2. Log error messages for debugging
# 3. Provide helpful error messages
# 4. Clean up resources in ensure
# 5. Raise errors with descriptive messages

# DON'T:
# 1. Rescue all errors with bare "rescue"
# 2. Silently ignore errors
# 3. Print to stdout in libraries (use logging)
# 4. Raise generic RuntimeError
# 5. Catch StandardError unless necessary

# BAD:
begin
  something()
rescue
  # Silently fails—hard to debug!
end

# GOOD:
begin
  something()
rescue ArgumentError => e
  puts "Invalid argument: #{e.message}"
rescue StandardError => e
  puts "Unexpected error: #{e.message}"
end

# ============================================================================
# KEY CONCEPTS SUMMARY
# ============================================================================

# 1. begin/rescue/end = Try/catch equivalent
# 2. => e = Capture error as variable
# 3. .message = Error description
# 4. .class = Error type
# 5. ensure = Always runs (finally block)
# 6. raise = Throw exception
# 7. retry = Retry begin block
# 8. rescue_modifier = Short form (a / b rescue 0)
# 9. Custom exceptions = Create your own error types
# 10. Specific errors > Generic errors

# ============================================================================
# PYTHON → RUBY
# ============================================================================

# Python:
#   try:
#       result = 10 / 0
#   except ZeroDivisionError:
#       print("Error")
#   finally:
#       cleanup()

# Ruby:
#   begin
#     result = 10 / 0
#   rescue ZeroDivisionError
#     puts "Error"
#   ensure
#     cleanup()
#   end

# ============================================================================
# PRACTICE EXERCISES
# ============================================================================

# 1. Safe division function
#    - Takes a, b as arguments
#    - Returns a/b or 0 if b is 0
#    - Logs error message

# 2. File reader with error handling
#    - Tries to open a file
#    - Returns contents or nil on error
#    - Always closes file (even on error)

# 3. Create a custom error
#    - Define ValidationError < StandardError
#    - Create validate_number(n) that raises if n < 0
#    - Test it with begin/rescue

# 4. Retry logic
#    - Create a function that randomly fails
#    - Call it with retry logic
#    - Stop after 3 attempts

puts "\n✓ Error Handling tutorial complete. Try the practice exercises above."
