# Functions and Methods Reference

Quick reference for defining and using functions in Ruby.

## Defining a Function

```ruby
def function_name(param1, param2)
  # code here
  result
end

# Call it
function_name("value1", "value2")
```

## Parameters

### Required Parameters
```ruby
def greet(name)
  "Hello, #{name}"
end

greet("Paul")  # Must provide argument
```

### Optional Parameters (Default Values)
```ruby
def greet(name = "Friend")
  "Hello, #{name}"
end

greet()           # Uses "Friend"
greet("Paul")     # Uses "Paul"
```

### Multiple Parameters
```ruby
def add(x, y, z = 0)
  x + y + z
end

add(1, 2)      # 3
add(1, 2, 3)   # 6
```

## Return Values

**Implicit return** (last line is returned):
```ruby
def multiply(x, y)
  x * y
end

result = multiply(3, 4)  # 12
```

**Explicit return**:
```ruby
def check_positive(num)
  return "positive" if num > 0
  return "negative" if num < 0
  "zero"
end
```

## Method Naming Conventions

```ruby
def load_data
  # loads something
end

def filter_long?  # ends with ? = returns true/false
  true
end

def save_to_file!  # ends with ! = modifies data (mutates)
  # saves and returns nothing
end
```

## Using Methods in Tests

```ruby
# spec/math_spec.rb
require 'rspec'
require_relative '../app/math_helper'

describe 'multiply' do
  it 'multiplies two numbers' do
    result = multiply(3, 4)
    expect(result).to eq(12)
  end
end
```

## Common Mistakes

❌ **Forgetting `end`**:
```ruby
def greet(name)
  "Hello, #{name}"
# Missing end!
```

❌ **Not returning a value**:
```ruby
def process(data)
  data.map { |x| x * 2 }
  # Implicitly returns the mapped array ✓
end
```

## Quick Test Pattern

```ruby
# app/helpers.rb
def filter_long(data, min_length)
  data.select { |row| row['text'].length > min_length }
end

# spec/helpers_spec.rb
describe 'filter_long' do
  it 'filters by length' do
    data = [{'text' => 'short'}, {'text' => 'much longer text'}]
    result = filter_long(data, 10)
    expect(result.length).to eq(1)
  end
end
```

---

**Remember**: Keep functions simple. One job per function. If it's doing multiple things, split it up.
