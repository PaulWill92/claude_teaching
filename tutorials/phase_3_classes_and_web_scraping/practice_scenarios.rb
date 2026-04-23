# Practice Scenarios: Building Toward the Web Scraper
# Work through these before tackling Project 2b

# Each scenario builds on previous ones. Do them in order.

# ============================================================================
# SCENARIO 1: Simple Data Fetcher (HTTP)
# ============================================================================

# Goal: Fetch a webpage and count words

require 'openuri'

def fetch_and_count(url)
  begin
    html = URI.open(url).read
    word_count = html.split.length
    { success: true, words: word_count, bytes: html.length }
  rescue OpenURI::HTTPError => e
    { success: false, error: e.message }
  end
end

# Test it:
# result = fetch_and_count('https://example.com')
# puts "Words: #{result[:words]}" if result[:success]

# ============================================================================
# SCENARIO 2: Parse HTML with Nokogiri
# ============================================================================

# Goal: Extract headings and links from static HTML

require 'nokogiri'

def extract_from_html(html_string)
  doc = Nokogiri::HTML(html_string)

  {
    headings: doc.css('h1, h2, h3').map(&:text),
    links: doc.css('a').map { |a| a['href'] },
    paragraphs: doc.css('p').map(&:text)
  }
end

# Test it:
test_html = <<~HTML
  <html>
    <h1>Title</h1>
    <p>First paragraph</p>
    <a href="https://example.com">Link</a>
  </html>
HTML

# result = extract_from_html(test_html)
# puts result

# ============================================================================
# SCENARIO 3: Combine Fetching + Parsing
# ============================================================================

# Goal: Fetch a real website and extract data

require 'openuri'
require 'nokogiri'

def scrape_headings(url)
  begin
    html = URI.open(url).read
    doc = Nokogiri::HTML(html)
    doc.css('h1, h2, h3').map(&:text)
  rescue OpenURI::HTTPError => e
    puts "Error: #{e.message}"
    []
  end
end

# Test it:
# headings = scrape_headings('https://example.com')
# puts headings

# ============================================================================
# SCENARIO 4: Build a Simple Scraper Class
# ============================================================================

# Goal: Create reusable Scraper class (preview of inheritance)

require 'openuri'
require 'nokogiri'

class SimpleScraper
  attr_reader :url, :data, :error

  def initialize(url)
    @url = url
    @data = []
    @error = nil
  end

  def scrape
    begin
      html = fetch
      parse(html)
      @data
    rescue StandardError => e
      @error = e.message
      []
    end
  end

  private

  def fetch
    URI.open(@url).read
  end

  def parse(html)
    doc = Nokogiri::HTML(html)
    @data = doc.css('h1, h2, h3').map(&:text)
  end
end

# Test it:
# scraper = SimpleScraper.new('https://example.com')
# headings = scraper.scrape
# puts headings

# ============================================================================
# SCENARIO 5: Inherit and Extend (Polymorphism)
# ============================================================================

# Goal: Create different scraper strategies using inheritance

class StaticPageScraper < SimpleScraper
  private

  def parse(html)
    doc = Nokogiri::HTML(html)
    @data = doc.css('p').map(&:text)  # Override: get paragraphs instead
  end
end

class LinkScraper < SimpleScraper
  private

  def parse(html)
    doc = Nokogiri::HTML(html)
    @data = doc.css('a').map { |a| { text: a.text, href: a['href'] } }
  end
end

# Test it:
# scraper1 = StaticPageScraper.new('https://example.com')
# paragraphs = scraper1.scrape
# puts paragraphs

# scraper2 = LinkScraper.new('https://example.com')
# links = scraper2.scrape
# puts links

# ============================================================================
# SCENARIO 6: Handle Missing Data Gracefully
# ============================================================================

# Goal: Parse HTML that might have missing elements

require 'nokogiri'

def extract_items(html_string)
  doc = Nokogiri::HTML(html_string)

  doc.css('div.item').map do |item|
    {
      title: item.css('h2').first&.text || 'N/A',
      price: item.css('.price').first&.text || 'N/A',
      description: item.css('.desc').first&.text || 'N/A'
    }
  end
end

test_data = <<~HTML
  <div class="item">
    <h2>Item 1</h2>
    <div class="price">$10</div>
  </div>
  <div class="item">
    <h2>Item 2</h2>
    <!-- Missing price -->
    <div class="desc">A nice item</div>
  </div>
HTML

# items = extract_items(test_data)
# items.each { |item| puts item }

# ============================================================================
# SCENARIO 7: Save Results to Files
# ============================================================================

# Goal: Scrape data and save to JSON/CSV

require 'csv'
require 'json'
require 'openuri'
require 'nokogiri'

class FileScrapingExample
  def scrape_and_save(url, output_file)
    # Fetch and parse
    html = URI.open(url).read
    doc = Nokogiri::HTML(html)

    data = doc.css('h1, h2').map { |h| { type: h.name, text: h.text } }

    # Save to JSON
    File.write("#{output_file}.json", JSON.pretty_generate(data))

    # Save to CSV
    CSV.open("#{output_file}.csv", 'w') do |csv|
      csv << ['Type', 'Text']
      data.each { |row| csv << [row[:type], row[:text]] }
    end

    puts "Saved to #{output_file}.json and #{output_file}.csv"
  end
end

# Usage:
# scraper = FileScrapingExample.new
# scraper.scrape_and_save('https://example.com', 'output/data')

# ============================================================================
# SCENARIO 8: Deep Scraping (Multiple Pages)
# ============================================================================

# Goal: Design for scraping multiple pages

class DeepScrapingExample
  def scrape_with_pagination(base_url, max_pages: 5)
    all_data = []

    (1..max_pages).each do |page|
      url = "#{base_url}?page=#{page}"
      puts "Scraping page #{page}..."

      begin
        html = URI.open(url).read
        doc = Nokogiri::HTML(html)
        items = doc.css('div.item').map { |item| item.css('h2').text }
        all_data.concat(items)
      rescue StandardError => e
        puts "Error on page #{page}: #{e.message}"
        break
      end
    end

    all_data
  end
end

# Design preview: In the real project, you'd:
# 1. Create a DeepScraper class
# 2. Override parse() to handle facets/pagination
# 3. Keep base Scraper logic (fetch, save)
# 4. Extend with specific site logic

# ============================================================================
# SCENARIO 9: Error Recovery and Retry
# ============================================================================

# Goal: Handle transient errors (network timeouts)

require 'openuri'

def fetch_with_retry(url, retries: 3, timeout: 10)
  attempts = 0

  begin
    attempts += 1
    URI.open(url, read_timeout: timeout).read

  rescue OpenURI::HTTPError, SocketError => e
    if attempts < retries
      puts "Attempt #{attempts} failed: #{e.message}. Retrying..."
      sleep 2
      retry
    else
      puts "Failed after #{retries} attempts"
      raise
    end
  end
end

# This is what you'll use in the real scraper

# ============================================================================
# SCENARIO 10: Testing Your Scraper Logic
# ============================================================================

# Goal: Write tests for scraper (without live websites)

# Create a test helper:
def test_parser
  test_html = <<~HTML
    <div class="product">
      <h2>Product 1</h2>
      <span class="price">$19.99</span>
    </div>
    <div class="product">
      <h2>Product 2</h2>
      <span class="price">$29.99</span>
    </div>
  HTML

  doc = Nokogiri::HTML(test_html)
  products = doc.css('div.product').map do |p|
    { name: p.css('h2').text, price: p.css('.price').text }
  end

  puts "Parsed #{products.length} products"
  products.each { |p| puts "#{p[:name]}: #{p[:price]}" }
end

# Run: test_parser

# ============================================================================
# PROGRESSION SUMMARY
# ============================================================================

# Scenario 1: Learn HTTP fetching
# Scenario 2: Learn HTML parsing
# Scenario 3: Combine both
# Scenario 4: Organize with classes
# Scenario 5: Use inheritance for different strategies
# Scenario 6: Handle edge cases
# Scenario 7: Save to files
# Scenario 8: Design for multiple pages
# Scenario 9: Handle errors with retry
# Scenario 10: Test without live sites

# After these, Project 2b will make sense!

# ============================================================================
# CHALLENGE: Build Your Own Scenario
# ============================================================================

# Create a scraper for a real website:
# 1. Identify the URL and elements to extract
# 2. Use OpenURI to fetch
# 3. Use Nokogiri to parse
# 4. Save results to JSON/CSV
# 5. Handle errors gracefully
# 6. Test it!

puts "\n✓ Practice scenarios complete. Ready for Project 2b!"
