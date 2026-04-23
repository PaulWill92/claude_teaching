# Nokogiri Tutorial: Parsing HTML
# Learn how to extract data from HTML (like BeautifulSoup in Python)

# Resources:
# - Nokogiri docs: https://nokogiri.org/
# - CSS selectors: https://nokogiri.org/tutorials/selecting_nodes.html
# - XPath: Search "Nokogiri XPath" on nokogiri.org
# - API docs: https://nokogiri.org/rdoc/Nokogiri.html

# Installation:
# Add to Gemfile: gem "nokogiri"
# Then: bundle install

# ============================================================================
# 1. PARSING HTML
# ============================================================================

require 'nokogiri'

html_string = <<~HTML
  <html>
    <body>
      <div class="container">
        <h1>Welcome</h1>
        <p class="intro">This is an intro.</p>
        <p class="content">This is content.</p>
      </div>
    </body>
  </html>
HTML

# Parse HTML string
doc = Nokogiri::HTML(html_string)

# Python equivalent:
# from bs4 import BeautifulSoup
# soup = BeautifulSoup(html_string, 'html.parser')

# ============================================================================
# 2. CSS SELECTORS (Finding Elements)
# ============================================================================

# Find all paragraphs
paragraphs = doc.css('p')
paragraphs.each { |p| puts p.text }
# Output:
# This is an intro.
# This is content.

# Find paragraph with class "intro"
intro = doc.css('p.intro').first
puts intro.text  # Output: This is an intro.

# Find all elements with class "content"
content = doc.css('.content')
puts content.text  # Output: This is content.

# Find h1 inside div
header = doc.css('div h1').first
puts header.text  # Output: Welcome

# Find by ID (if it existed)
# element = doc.css('#my-id').first

# ============================================================================
# 3. XPATH SELECTORS (Alternative to CSS)
# ============================================================================

# CSS selectors are usually easier, but XPath is more powerful
# Search "Nokogiri XPath" to learn syntax

# Find all paragraphs (XPath version)
paragraphs_xpath = doc.xpath('//p')

# Find paragraph with specific text
paragraphs_text = doc.xpath("//p[contains(text(), 'intro')]")

# Most cases: use CSS selectors. XPath for complex queries.

# ============================================================================
# 4. EXTRACTING DATA
# ============================================================================

html_with_data = <<~HTML
  <html>
    <body>
      <div class="item">
        <h2 class="title">Ruby Book</h2>
        <p class="price">$29.99</p>
        <p class="description">Learn Ruby the hard way</p>
      </div>
      <div class="item">
        <h2 class="title">Rails Guide</h2>
        <p class="price">$39.99</p>
        <p class="description">Build web apps</p>
      </div>
    </body>
  </html>
HTML

doc = Nokogiri::HTML(html_with_data)

# Extract multiple items
items = doc.css('div.item')
puts "Found #{items.length} items"

items.each do |item|
  title = item.css('h2.title').text
  price = item.css('p.price').text
  description = item.css('p.description').text

  puts "Title: #{title}"
  puts "Price: #{price}"
  puts "Description: #{description}"
  puts "---"
end

# ============================================================================
# 5. ATTRIBUTES
# ============================================================================

html_with_links = <<~HTML
  <html>
    <body>
      <a href="https://example.com" class="link">Example</a>
      <img src="image.jpg" alt="My Image">
      <input type="text" name="username">
    </body>
  </html>
HTML

doc = Nokogiri::HTML(html_with_links)

# Get attribute value
link = doc.css('a.link').first
href = link['href']  # or link.attr('href')
puts href  # Output: https://example.com

# Get image src
image = doc.css('img').first
puts image['src']  # Output: image.jpg

# Get input name
input = doc.css('input').first
puts input['name']  # Output: username

# ============================================================================
# 6. TEXT vs INNER_HTML vs OUTER_HTML
# ============================================================================

html_example = <<~HTML
  <div class="container">
    <p>Hello <strong>World</strong></p>
  </div>
HTML

doc = Nokogiri::HTML(html_example)
element = doc.css('p').first

# .text = Just the text content
puts element.text  # Output: Hello World

# .inner_html = HTML inside the tag
puts element.inner_html  # Output: Hello <strong>World</strong>

# .outer_html = Full HTML including tag
puts element.outer_html  # Output: <p>Hello <strong>World</strong></p>

# ============================================================================
# 7. HANDLING MISSING ELEMENTS
# ============================================================================

html_incomplete = <<~HTML
  <div class="item">
    <h2>Title</h2>
    <!-- price is missing -->
  </div>
HTML

doc = Nokogiri::HTML(html_incomplete)
item = doc.css('div.item').first

title = item.css('h2').text
price = item.css('p.price').text  # Returns empty string

puts "Title: #{title}"
puts "Price: #{price.empty? ? 'N/A' : price}"

# Safe chaining: check if element exists first
price_element = item.css('p.price').first
price = price_element ? price_element.text : 'N/A'

puts "Price: #{price}"

# ============================================================================
# 8. PRACTICE: Build a Simple Parser Class
# ============================================================================

require 'nokogiri'

class SimpleParser
  attr_reader :doc

  def initialize(html_string)
    @doc = Nokogiri::HTML(html_string)
  end

  def extract_titles
    # Search "Nokogiri css selector" for more examples
    @doc.css('h1, h2, h3').map(&:text)
  end

  def extract_links
    @doc.css('a').map do |link|
      {
        text: link.text,
        href: link['href']
      }
    end
  end

  def extract_paragraphs
    @doc.css('p').map(&:text)
  end
end

# Usage:
# parser = SimpleParser.new(html_string)
# puts parser.extract_titles
# puts parser.extract_links
# puts parser.extract_paragraphs

# ============================================================================
# 9. PARSING REAL WEBSITES
# ============================================================================

# For real websites, combine HTTP requests with Nokogiri:

require 'openuri'
require 'nokogiri'

def scrape_example_com
  html = URI.open('https://example.com').read
  doc = Nokogiri::HTML(html)

  titles = doc.css('h1').map(&:text)
  titles
end

# This is what you'll do in the Web Scraper project!

# ============================================================================
# 10. PERFORMANCE TIP: Caching
# ============================================================================

# Don't parse HTML multiple times:

class CachedParser
  def initialize(html_string)
    @html = html_string
    @doc = Nokogiri::HTML(html_string)
  end

  # Parse once, reuse many times
  def titles
    @doc.css('h1').map(&:text)
  end

  def links
    @doc.css('a').map { |a| a['href'] }
  end
end

# ============================================================================
# KEY CONCEPTS SUMMARY
# ============================================================================

# 1. Nokogiri::HTML(html_string) = Parse HTML
# 2. doc.css('selector') = Find elements (CSS selector)
# 3. element.text = Get text content
# 4. element['attr'] = Get attribute value
# 5. element.inner_html = HTML inside tag
# 6. element.outer_html = Full HTML including tag
# 7. .first = Get first match
# 8. .each = Loop through matches
# 9. .map = Transform results
# 10. .empty? = Check if string is blank

# ============================================================================
# PYTHON → RUBY
# ============================================================================

# Python:
#   from bs4 import BeautifulSoup
#   soup = BeautifulSoup(html, 'html.parser')
#   titles = [h1.text for h1 in soup.find_all('h1')]
#   link = soup.find('a')['href']

# Ruby:
#   require 'nokogiri'
#   doc = Nokogiri::HTML(html)
#   titles = doc.css('h1').map(&:text)
#   link = doc.css('a').first['href']

# ============================================================================
# PRACTICE EXERCISES
# ============================================================================

# 1. Parse example.com
#    - Extract all h1, h2 headings
#    - Extract all links with href
#    - Extract all paragraphs

# 2. Create a Parser class that:
#    - Takes HTML string in initialize
#    - Has method titles() returning all headings
#    - Has method links() returning all href values
#    - Has method has_email? checking if email mentioned

# 3. Handle missing elements
#    - Parse HTML with some missing fields
#    - Return 'N/A' for missing elements
#    - Don't crash on nil

# 4. Extract structured data
#    - Parse a list of items
#    - Extract title, price, description from each
#    - Return as array of hashes: [{title: '...', price: '...'}]

puts "\n✓ Nokogiri tutorial complete. Try the practice exercises above."
