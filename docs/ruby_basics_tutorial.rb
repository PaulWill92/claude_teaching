# Ruby Basics Tutorial - Coming from Python
# This file teaches: file loading, iteration, conditionals, saving

require 'csv'
require 'json'

puts "\n=== 1. LOADING DATA FROM A FILE ==="

# Python: import pandas as pd; df = pd.read_csv('file.csv')
# Ruby: CSV.read('file.csv', headers: true)

data = CSV.read('./data/all_summaries_26-03-2026.csv', headers: true)
puts "Loaded #{data.length} rows"
puts "First row: #{data[0]}"  # Access first row like a list


puts "\n=== 2. ITERATING OVER DATA ==="

# Python: for row in df.iterrows(): print(row)
# Ruby: data.each do |row| ... end

puts "--- Using .each (most common) ---"
data.take(2).each do |row|
  puts "Summary: #{row['Summary']}"
end

# Python: [x * 2 for x in my_list]
# Ruby: my_list.map { |x| x * 2 }

puts "\n--- Using .map (transform data) ---"
summaries = data.take(3).map { |row| row['Summary'] }
puts "First 3 summaries:"
summaries.each { |s| puts "  - #{s[0..50]}..." }  # First 50 chars

# Python: df[df['column'] > 5]
# Ruby: data.select { |row| condition }

puts "\n--- Using .select (filter data) ---"
long_summaries = data.select { |row| row['Summary'].length > 200 }
puts "Found #{long_summaries.length} summaries longer than 200 characters"


puts "\n=== 3. IF/ELSIF/ELSE STATEMENTS ==="

# Python: if x > 5: ... elif x > 2: ... else: ...
# Ruby: if condition ... elsif condition ... else ... end

test_values = [10, 5, 2, -1]
test_values.each do |value|
  if value > 5
    puts "#{value} is greater than 5"
  elsif value > 2
    puts "#{value} is between 2 and 5"
  elsif value >= 0
    puts "#{value} is between 0 and 2"
  else
    puts "#{value} is negative"
  end
end


puts "\n=== 4. IF/OR LOGIC ==="

# Python: if x > 5 or x < -5: ...
# Ruby: if x > 5 || x < -5 ... (double pipe for OR)

values = [10, 3, -8, 0]
values.each do |v|
  if v > 5 || v < -5
    puts "#{v} is extreme (greater than 5 OR less than -5)"
  else
    puts "#{v} is normal"
  end
end

# Python: if x > 5 and x < 10: ...
# Ruby: if x > 5 && x < 10 ... (double ampersand for AND)

puts "\n--- AND logic ---"
values.each do |v|
  if v > -10 && v < 10
    puts "#{v} is between -10 and 10"
  end
end


puts "\n=== 5. TERNARY OPERATOR (shorthand if) ==="

# Python: x if condition else y
# Ruby: condition ? x : y

values.each do |v|
  status = v > 0 ? "positive" : "not positive"
  puts "#{v} is #{status}"
end


puts "\n=== 6. STORING DATA IN MEMORY ==="

# Python: data_dict = {'key': value, ...}
# Ruby: hash = {'key' => value} or hash = {key: value}

person = {
  'name' => 'John',
  'age' => 30,
  'city' => 'London'
}

puts "Person: #{person}"
puts "Access name: #{person['name']}"

# Python: data_list = [1, 2, 3]
# Ruby: array = [1, 2, 3]

numbers = [1, 2, 3, 4, 5]
puts "Numbers: #{numbers}"
puts "First: #{numbers[0]}, Last: #{numbers[-1]}"

# Python: my_dict['new_key'] = new_value
# Ruby: my_hash['key'] = value

person['job'] = 'Engineer'
puts "Updated person: #{person}"


puts "\n=== 7. PROCESSING AND STORING RESULTS ==="

# Python: results = []
#         for row in df: results.append(row['col'] * 2)
# Ruby: results = []; data.each { |row| results << row['value'] * 2 }

puts "--- Processing data and storing results ---"
results = []
data.take(5).each do |row|
  summary_length = row['Summary'].length
  results << {
    'original_summary' => row['Summary'][0..50],
    'length' => summary_length,
    'is_long' => summary_length > 100
  }
end

puts "Processed #{results.length} rows:"
results.each do |result|
  puts "  Length: #{result['length']}, Is long: #{result['is_long']}"
end


puts "\n=== 8. SAVING DATA TO FILE ==="

# Python: df.to_csv('output.csv')
# Ruby: CSV.open('output.csv', 'w') { |csv| csv << row }

puts "--- Saving to CSV ---"
output_path = './data/tutorial_output.csv'
CSV.open(output_path, 'w') do |csv|
  # Write header
  csv << ['summary', 'length', 'is_long']

  # Write data rows
  results.each do |result|
    csv << [result['original_summary'], result['length'], result['is_long']]
  end
end
puts "Saved #{results.length} rows to #{output_path}"

# Python: with open('data.json', 'w') as f: json.dump(data, f)
# Ruby: File.write('data.json', JSON.pretty_generate(data))

puts "\n--- Saving to JSON ---"
json_output = './data/tutorial_output.json'
File.write(json_output, JSON.pretty_generate(results))
puts "Saved to #{json_output}"


puts "\n=== 9. KEY RUBY DIFFERENCES FROM PYTHON ==="

puts "1. No colons or indentation - use 'end' keyword"
puts "   Python: if x > 5:"
puts "               print(x)"
puts "   Ruby:   if x > 5"
puts "             puts x"
puts "           end"

x = 42
puts "\n2. String interpolation - use #{ } to embed variables"
puts "   Python: f'Value is {x}'"
puts "   Ruby:   Value is #{x}"

puts "\n3. Symbols (:symbol) - lightweight identifiers"
my_hash = {name: 'John', age: 30}  # Keys are symbols
puts "   hash = {name: 'John', age: 30}"
puts "   Access: #{my_hash[:name]}"

puts "\n4. Array/Hash methods are chainable"
result = data
  .take(10)
  .map { |row| row['Summary'] }
  .select { |s| s.length > 100 }
puts "   Found #{result.length} summaries over 100 chars in first 10 rows"

puts "\n5. Blocks { |var| ... } vs lambdas -> (var) { ... }"
puts "   Most common: .each { |item| ... }"

puts "\nTutorial complete! Experiment with the code above."
