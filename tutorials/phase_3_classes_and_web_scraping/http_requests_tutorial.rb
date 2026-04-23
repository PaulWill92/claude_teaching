# HTTP Requests Tutorial: Fetching Data from the Web
# Learn how to make HTTP requests in Ruby (like requests in Python)

# Resources:
# - Net::HTTP docs: https://ruby-doc.org/stdlib/libdoc/net/http/rdoc/Net/HTTP.html
# - HTTP basics: Search "Ruby HTTP GET requests" on ruby-doc.org
# - OpenURI: Search "Ruby openuri" on ruby-doc.org for simpler approach
# - Error handling: Search "Ruby begin rescue end" on ruby-doc.org

# ============================================================================
# 1. SIMPLE GET REQUEST (Net::HTTP)
# ============================================================================

require 'net/http'
require 'uri'

# Python equivalent:
# import requests
# response = requests.get('https://example.com')
# print(response.text)

# Ruby with Net::HTTP:
def fetch_url(url_string)
  url = URI.parse(url_string)

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = (url.scheme == 'https')

  request = Net::HTTP::Get.new(url.request_uri)
  response = http.request(request)

  response.body
end

# Usage:
# html = fetch_url('https://example.com')
# puts html

# ============================================================================
# 2. SIMPLER APPROACH: Using OpenURI
# ============================================================================

require 'openuri'

# Much simpler! Works for basic GET requests
# Equivalent to Python's requests.get()

def fetch_with_openuri(url_string)
  URI.open(url_string).read
rescue OpenURI::HTTPError => e
  puts "Error fetching #{url_string}: #{e.message}"
  nil
end

# Usage:
# html = fetch_with_openuri('https://example.com')

# ============================================================================
# 3. HANDLING ERRORS
# ============================================================================

require 'openuri'

def fetch_page(url, retries = 2)
  attempts = 0

  begin
    attempts += 1
    html = URI.open(url).read
    html

  rescue OpenURI::HTTPError => e
    # Search "Ruby OpenURI errors" to see all error types
    if attempts < retries
      puts "Attempt #{attempts} failed, retrying..."
      sleep 1
      retry
    else
      puts "Failed after #{retries} attempts: #{e.message}"
      nil
    end

  rescue SocketError => e
    # Network error (no internet, DNS failed)
    puts "Network error: #{e.message}"
    nil

  rescue Timeout::Error => e
    # Request took too long
    puts "Request timed out: #{e.message}"
    nil
  end
end

# Usage:
# html = fetch_page('https://example.com', retries: 3)

# ============================================================================
# 4. ADDING HEADERS (User-Agent, etc)
# ============================================================================

require 'net/http'

def fetch_with_headers(url_string)
  url = URI.parse(url_string)

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = (url.scheme == 'https')

  request = Net::HTTP::Get.new(url.request_uri)

  # Add headers to look like a real browser
  # Search "Ruby HTTP headers" on ruby-doc.org
  request['User-Agent'] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)'
  request['Accept'] = 'text/html,application/xhtml+xml'

  response = http.request(request)
  response.body
end

# Some websites block requests without proper User-Agent headers

# ============================================================================
# 5. GETTING RESPONSE METADATA
# ============================================================================

require 'net/http'

def fetch_with_status(url_string)
  url = URI.parse(url_string)

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = (url.scheme == 'https')

  response = http.request(Net::HTTP::Get.new(url.request_uri))

  # Check response status
  case response.code.to_i
  when 200..299
    puts "Success: #{response.code}"
    response.body
  when 300..399
    puts "Redirect: #{response.code}"
    nil
  when 400..499
    puts "Client error: #{response.code}"
    nil
  when 500..599
    puts "Server error: #{response.code}"
    nil
  else
    puts "Unknown status: #{response.code}"
    nil
  end
end

# Common status codes:
# 200 = OK (success)
# 301/302 = Redirect
# 404 = Not Found
# 500 = Server Error

# ============================================================================
# 6. POST REQUESTS (Sending Data)
# ============================================================================

require 'net/http'
require 'json'

def post_json(url_string, data)
  url = URI.parse(url_string)

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = (url.scheme == 'https')

  request = Net::HTTP::Post.new(url.request_uri)
  request['Content-Type'] = 'application/json'
  request.body = JSON.generate(data)

  response = http.request(request)
  response.body
end

# Usage:
# data = { name: "Paul", email: "paul@example.com" }
# post_json('https://api.example.com/users', data)

# ============================================================================
# 7. TIMEOUTS (Don't Wait Forever)
# ============================================================================

require 'net/http'
require 'timeout'

def fetch_with_timeout(url_string, timeout_seconds = 10)
  url = URI.parse(url_string)

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = (url.scheme == 'https')
  http.read_timeout = timeout_seconds  # Max time to wait for response

  begin
    response = http.request(Net::HTTP::Get.new(url.request_uri))
    response.body
  rescue Net::ReadTimeout
    puts "Request timed out after #{timeout_seconds} seconds"
    nil
  end
end

# ============================================================================
# 8. PRACTICE: Simple Fetcher Class
# ============================================================================

require 'openuri'

class SimpleFetcher
  attr_reader :url, :html, :status

  def initialize(url)
    @url = url
    @html = nil
    @status = nil
  end

  def fetch
    begin
      @html = URI.open(@url).read
      @status = :success
      @html
    rescue OpenURI::HTTPError => e
      @status = :http_error
      puts "HTTP Error: #{e.message}"
      nil
    rescue StandardError => e
      @status = :error
      puts "Error: #{e.message}"
      nil
    end
  end

  def success?
    @status == :success
  end
end

# Usage:
# fetcher = SimpleFetcher.new('https://example.com')
# fetcher.fetch
# puts "Success!" if fetcher.success?
# puts fetcher.html

# ============================================================================
# KEY CONCEPTS SUMMARY
# ============================================================================

# 1. Net::HTTP = Lower level, more control
# 2. OpenURI = Simpler, good for basic GET requests
# 3. URI.parse = Convert string to URL object
# 4. request.body = Data to send (POST)
# 5. response.code = HTTP status code
# 6. response.body = HTML/JSON response
# 7. begin/rescue/end = Error handling
# 8. Timeout = Set max wait time

# ============================================================================
# PYTHON → RUBY
# ============================================================================

# Python:
#   import requests
#   response = requests.get('https://example.com')
#   print(response.status_code, response.text)

# Ruby (OpenURI):
#   require 'openuri'
#   html = URI.open('https://example.com').read
#   puts html

# Ruby (Net::HTTP, more control):
#   url = URI.parse('https://example.com')
#   http = Net::HTTP.new(url.host, url.port)
#   response = http.request(Net::HTTP::Get.new(url.request_uri))
#   puts response.code, response.body

# ============================================================================
# PRACTICE EXERCISES
# ============================================================================

# 1. Fetch a webpage and print its length
#    - Use OpenURI
#    - Handle errors
#    - Print "Success: X bytes" or error message

# 2. Create a Fetcher class that:
#    - Takes a URL in initialize
#    - Has a fetch method
#    - Has a success? method
#    - Handles errors gracefully

# 3. Fetch multiple URLs and collect results
#    - Make a list of URLs
#    - Fetch each one
#    - Collect successes and failures

# 4. Add retry logic
#    - Fetch a URL with automatic retries
#    - Wait 1 second between retries
#    - Stop after 3 attempts

puts "\n✓ HTTP Requests tutorial complete. Try the practice exercises above."
