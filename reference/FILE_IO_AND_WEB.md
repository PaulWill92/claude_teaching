# File I/O and Web Scraping Reference

Search keywords: files, csv, json, loading, reading, writing, scraping, web, http, html, parsing, fetch, download

---

## Reading Files

### Read CSV Files
```ruby
# Search: csv reading, loading csv, csv parse, csv data
require 'csv'

# Read CSV with headers
CSV.read('data.csv', headers: true).each do |row|
  puts row['name']  # Access by column name
end

# Read CSV without headers
CSV.read('data.csv').each do |row|
  puts row[0]  # Access by index
end

# Parse CSV string directly
csv_string = "name,age\nPaul,30"
CSV.parse(csv_string, headers: true) do |row|
  puts row['name']
end
```

### Read JSON Files
```ruby
# Search: json reading, json parse, json data, json load
require 'json'

# Read and parse JSON file
data = JSON.parse(File.read('data.json'))
puts data['key']

# Pretty print JSON
puts JSON.pretty_generate(data)
```

### Read Plain Text Files
```ruby
# Search: text file, read file, plain text, file content
content = File.read('file.txt')
puts content

# Read line by line
File.readlines('file.txt').each do |line|
  puts line.strip  # Remove newline
end

# Read with block (memory efficient for large files)
File.foreach('file.txt') do |line|
  process(line)
end
```

### Read XML Files
```ruby
# Search: xml parsing, xml file, nokogiri
require 'nokogiri'

doc = Nokogiri::XML(File.read('data.xml'))
doc.xpath('//item').each do |item|
  puts item['id']
end
```

---

## Writing Files

### Write to Files
```ruby
# Search: write file, save file, file output, create file
# Simple write (overwrites)
File.write('output.txt', 'Hello, World!')

# Append to file
File.open('output.txt', 'a') do |f|
  f.puts 'New line'
end

# Write multiple lines
lines = ['Line 1', 'Line 2', 'Line 3']
File.write('output.txt', lines.join("\n"))
```

### Write CSV Files
```ruby
# Search: csv write, csv output, save csv
require 'csv'

CSV.open('output.csv', 'w') do |csv|
  csv << ['name', 'age']  # Header
  csv << ['Paul', 30]
  csv << ['Jane', 25]
end

# Or convert array to CSV
data = [['name', 'age'], ['Paul', 30]]
File.write('output.csv', data.map { |row| row.join(',') }.join("\n"))
```

### Write JSON Files
```ruby
# Search: json write, json output, save json
require 'json'

data = { name: 'Paul', age: 30 }
File.write('output.json', JSON.pretty_generate(data))
```

---

## Web Scraping Basics

### Fetch Web Pages
```ruby
# Search: fetch, http request, download page, web scraping, fetch url
require 'open-uri'

# Simple fetch with error handling
begin
  html = URI.open('https://example.com').read
  puts html
rescue OpenURI::HTTPError => e
  puts "Failed to fetch: #{e.message}"
rescue SocketError => e
  puts "Network error: #{e.message}"
end

# Fetch with timeout
html = URI.open('https://example.com', read_timeout: 5).read

# Fetch with headers
html = URI.open(
  'https://example.com',
  'User-Agent' => 'Mozilla/5.0'
).read
```

### Parse HTML
```ruby
# Search: html parsing, nokogiri, extract data, scrape web, css selector
require 'nokogiri'

html = URI.open('https://example.com').read
doc = Nokogiri::HTML(html)

# Select by CSS selector
doc.css('.product').each do |product|
  puts product.css('h2').text
  puts product.css('.price').text
end

# Select by XPath
doc.xpath('//div[@class="product"]').each do |product|
  name = product.xpath('.//h2').text
  price = product.xpath('.//span[@class="price"]').text
end

# Get text content
title = doc.css('h1').first.text
```

### Scrape with Error Handling
```ruby
# Search: scrape error, retry, timeout, robust scraping
require 'open-uri'
require 'nokogiri'

def fetch_page(url, retries: 3)
  attempt = 0
  begin
    URI.open(url, read_timeout: 5).read
  rescue OpenURI::HTTPError, SocketError, Timeout::Error => e
    attempt += 1
    if attempt <= retries
      puts "Attempt #{attempt} failed: #{e.message}. Retrying..."
      sleep 2  # Wait before retry
      retry
    else
      raise "Failed after #{retries} attempts"
    end
  end
end

html = fetch_page('https://example.com')
doc = Nokogiri::HTML(html)
```

---

## Common Patterns

### Load → Transform → Save
```ruby
# Search: pipeline, load and save, process data
require 'csv'
require 'json'

# 1. Load CSV
data = CSV.read('input.csv', headers: true)

# 2. Transform
results = data.map do |row|
  {
    name: row['name'].upcase,
    age: row['age'].to_i
  }
end

# 3. Save as JSON
File.write('output.json', JSON.pretty_generate(results))
```

### Scrape and Save
```ruby
# Search: scrape and save, scrape to file, web to csv
require 'nokogiri'
require 'csv'
require 'open-uri'

url = 'https://example.com'
html = URI.open(url).read
doc = Nokogiri::HTML(html)

# Extract data
data = doc.css('.item').map do |item|
  {
    title: item.css('h2').text,
    price: item.css('.price').text
  }
end

# Save to CSV
CSV.open('scrape_results.csv', 'w') do |csv|
  csv << data.first.keys  # Headers
  data.each { |row| csv << row.values }
end
```

---

## File Paths and Directories

### Work with Paths
```ruby
# Search: path, directory, file path, relative path
require 'pathname'

# Relative to current directory
file = File.join(Dir.pwd, 'data.csv')

# Use Pathname for easier path operations
path = Pathname.new('data/input.csv')
puts path.exist?
puts path.extname  # '.csv'
puts path.basename  # 'input.csv'

# Check if file exists
if File.exist?('data.csv')
  puts 'File found'
end

# List files in directory
Dir.glob('data/*.csv').each do |file|
  puts file
end
```

---

## Performance Tips

### Large Files
```ruby
# Search: large file, streaming, memory efficient, big data
# Use foreach instead of readlines for large files
File.foreach('huge_file.txt') do |line|
  # Process one line at a time
  process(line)
end

# For CSV: use enumerator
CSV.open('large.csv', headers: true) do |csv|
  csv.each do |row|
    process(row)
  end
end
```

### Rate Limiting for Web Scraping
```ruby
# Search: scrape multiple, rate limit, polite scraping
require 'open-uri'

urls = ['url1', 'url2', 'url3']
urls.each do |url|
  html = URI.open(url).read
  # Process...
  
  sleep 2  # Wait between requests (be polite!)
end
```

---

## Common Gems

| Task | Gem | Install |
|------|-----|---------|
| Web scraping | nokogiri | `gem 'nokogiri'` |
| HTTP requests | net-http (built-in) | N/A |
| CSV handling | csv (built-in) | N/A |
| JSON handling | json (built-in) | N/A |
| File I/O | fileutils (built-in) | N/A |

---

See also: [LOOPS_AND_ITERATION.md](./LOOPS_AND_ITERATION.md), [TESTING_WITH_RSPEC.md](./TESTING_WITH_RSPEC.md)
