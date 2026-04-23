# Testing with RSpec Reference

Quick reference for writing tests in RSpec.

## Basic Test Structure

```ruby
# spec/example_spec.rb
require 'rspec'
require_relative '../app/example'  # File being tested

describe 'function_name' do
  it 'does something' do
    result = function_name()
    expect(result).to eq(expected_value)
  end
end
```

## Running Tests

```bash
# Run all tests
bundle exec rspec

# Run one file
bundle exec rspec spec/example_spec.rb

# Run specific test
bundle exec rspec spec/example_spec.rb:5

# Pretty output
bundle exec rspec --format documentation
```

## Common Matchers

```ruby
expect(value).to eq(expected)           # Equality
expect(value).to be_nil                 # Is nil
expect(value).to be true / be false     # Boolean
expect(array).to include(item)          # Array contains
expect(array).to be_empty               # Array is empty
expect(string).to start_with("Hello")   # String starts
expect(string).to match(/regex/)        # Regex match
expect { code }.to raise_error          # Raises error
```

## Testing Functions

```ruby
# app/math.rb
def add(x, y)
  x + y
end

# spec/math_spec.rb
require 'rspec'
require_relative '../app/math'

describe 'add' do
  it 'adds two numbers' do
    result = add(2, 3)
    expect(result).to eq(5)
  end
  
  it 'returns zero when adding negatives' do
    result = add(5, -5)
    expect(result).to eq(0)
  end
end
```

## Testing Classes

```ruby
# app/user.rb
class User
  attr_reader :name, :age
  
  def initialize(name, age)
    @name = name
    @age = age
  end
  
  def adult?
    @age >= 18
  end
end

# spec/user_spec.rb
require 'rspec'
require_relative '../app/user'

describe 'User' do
  it 'initializes with name and age' do
    user = User.new("Paul", 30)
    expect(user.name).to eq("Paul")
    expect(user.age).to eq(30)
  end
  
  it 'identifies adults' do
    user = User.new("Paul", 30)
    expect(user.adult?).to be true
  end
  
  it 'identifies minors' do
    user = User.new("Sam", 15)
    expect(user.adult?).to be false
  end
end
```

## Testing with Arrays

```ruby
def filter_long(data, min_length)
  data.select { |row| row['text'].length > min_length }
end

describe 'filter_long' do
  it 'filters data by length' do
    data = [
      {'text' => 'short'},
      {'text' => 'this is a much longer text'},
      {'text' => 'medium'}
    ]
    
    result = filter_long(data, 10)
    
    expect(result.length).to eq(1)
    expect(result[0]['text']).to include('longer')
  end
  
  it 'handles empty data' do
    result = filter_long([], 100)
    expect(result).to be_empty
  end
end
```

## Before and After Hooks

Setup data before each test:

```ruby
describe 'User' do
  before do
    @user = User.new("Paul", 30)
  end
  
  it 'has a name' do
    expect(@user.name).to eq("Paul")
  end
  
  it 'is an adult' do
    expect(@user.adult?).to be true
  end
end
```

## Debugging Tests with Pry

```ruby
it 'filters data' do
  data = [...]
  
  binding.pry  # Pauses execution here
  
  result = filter_long(data, 50)
  expect(result.length).to eq(2)
end
```

When you run `rspec`, it pauses at `binding.pry`. You can:
- `data` — inspect the data
- `data.length` — check array length
- `filter_long(data, 50)` — test the function
- `exit` — continue the test

## Test File Naming

```
app/
  models/
    user.rb
    summary.rb
  helpers/
    math.rb

spec/
  models/
    user_spec.rb        # Matches app/models/user.rb
    summary_spec.rb
  helpers/
    math_spec.rb        # Matches app/helpers/math.rb
```

## Common Test Patterns

**Test one thing per test**:
```ruby
# ✓ Good - focused
it 'returns 5 when adding 2 and 3' do
  expect(add(2, 3)).to eq(5)
end

# ✗ Bad - tests multiple things
it 'does arithmetic' do
  expect(add(2, 3)).to eq(5)
  expect(subtract(5, 2)).to eq(3)
end
```

**Test edge cases**:
```ruby
describe 'filter_long' do
  it 'filters normal data' do
    # ... normal test
  end
  
  it 'handles empty array' do
    expect(filter_long([], 50)).to be_empty
  end
  
  it 'handles nil values' do
    # Test what happens with bad input
  end
end
```

## Quick Checklist

- [ ] Test file in `spec/` mirrors `app/` structure
- [ ] File ends with `_spec.rb`
- [ ] Each test does one thing
- [ ] Edge cases covered (empty, nil, boundary)
- [ ] Clear test names (explain what and why)
- [ ] All tests pass: `bundle exec rspec`

---

**Remember**: Tests are documentation. A good test shows how to use the code.
