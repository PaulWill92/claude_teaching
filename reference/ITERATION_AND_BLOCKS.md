# Iteration and Blocks Reference

Common iteration patterns in Ruby.

## .each (Iterate Over All)

```ruby
# Simplest iteration
numbers = [1, 2, 3]
numbers.each { |n| puts n }

# Multi-line syntax
numbers.each do |n|
  puts n
  puts n * 2
end

# With hashes
person = {name: "Paul", age: 30}
person.each do |key, value|
  puts "#{key}: #{value}"
end
```

## .map (Transform Data)

Returns a new array with transformed values:

```ruby
numbers = [1, 2, 3]
doubled = numbers.map { |n| n * 2 }
# doubled = [2, 4, 6]

summaries = ["short", "medium text", "very long text"]
lengths = summaries.map { |s| s.length }
# lengths = [5, 11, 14]
```

## .select (Filter Data)

Returns only items matching a condition:

```ruby
numbers = [1, 2, 3, 4, 5]
evens = numbers.select { |n| n.even? }
# evens = [2, 4]

data = [{name: "Paul", age: 30}, {name: "Jo", age: 25}]
young = data.select { |person| person[:age] < 28 }
# young = [{name: "Jo", age: 25}]
```

## .find (First Match)

Returns first item matching condition:

```ruby
numbers = [1, 2, 3, 4, 5]
first_even = numbers.find { |n| n.even? }
# first_even = 2

data = [{id: 1, name: "Paul"}, {id: 2, name: "Jo"}]
user = data.find { |u| u[:id] == 2 }
# user = {id: 2, name: "Jo"}
```

## Method Chaining

Combine methods:

```ruby
numbers = [1, 2, 3, 4, 5, 6]

# Chain multiple operations
result = numbers
  .select { |n| n > 2 }
  .map { |n| n * 2 }
  .take(2)
# [6, 8]

# Breaking it down:
# select { |n| n > 2 }    → [3, 4, 5, 6]
# map { |n| n * 2 }       → [6, 8, 10, 12]
# take(2)                 → [6, 8]
```

## Blocks vs Code

```ruby
# Block syntax { } - single line
numbers.each { |n| puts n }

# do...end syntax - multi-line
numbers.each do |n|
  puts n
  puts n * 2
end

# Both are equivalent, use { } for one-liners, do...end for multiple lines
```

## Common Predicates

Methods that return true/false, end with `?`:

```ruby
numbers = [1, 2, 3, 4, 5]

# .any? - at least one matches
numbers.any? { |n| n > 4 }    # true

# .all? - all match
numbers.all? { |n| n > 0 }    # true

# .none? - none match
numbers.none? { |n| n > 10 }  # true
```

## With Data Structures

**Arrays of Hashes** (common in data processing):

```ruby
data = [
  {name: "Paul", age: 30},
  {name: "Jo", age: 25},
  {name: "Sam", age: 35}
]

# Filter
young = data.select { |p| p[:age] < 30 }
# [{name: "Jo", age: 25}]

# Extract field
names = data.map { |p| p[:name] }
# ["Paul", "Jo", "Sam"]

# Find one
person = data.find { |p| p[:name] == "Jo" }
# {name: "Jo", age: 25}
```

## Testing Blocks

```ruby
require 'rspec'

describe 'Array iteration' do
  it 'filters even numbers' do
    numbers = [1, 2, 3, 4, 5]
    evens = numbers.select { |n| n.even? }
    expect(evens).to eq([2, 4])
  end
  
  it 'doubles numbers' do
    numbers = [1, 2, 3]
    doubled = numbers.map { |n| n * 2 }
    expect(doubled).to eq([2, 4, 6])
  end
end
```

## Common Mistakes

❌ **Forgetting the block variable**:
```ruby
numbers = [1, 2, 3]
numbers.map { 2 }  # Returns [2, 2, 2] - block variable |n| not used
```

❌ **Using .each when you need .map**:
```ruby
# Wrong - .each returns original array
numbers = [1, 2, 3]
doubled = numbers.each { |n| n * 2 }  # doubled = [1, 2, 3]

# Right - .map returns new array
doubled = numbers.map { |n| n * 2 }   # doubled = [2, 4, 6]
```

---

**Remember**: 
- `.each` → iterate, don't care about return
- `.map` → transform into new array
- `.select` → filter into new array
- `.find` → get first match
