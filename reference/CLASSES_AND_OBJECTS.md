# Classes and Objects Reference

Quick reference for defining classes in Ruby.

## Basic Class

```ruby
class Summary
  def initialize(text)
    @text = text
  end
  
  def text
    @text
  end
  
  def length
    @text.length
  end
end

# Create an object
summary = Summary.new("Hello world")
summary.text       # "Hello world"
summary.length     # 11
```

## Instance Variables

Start with `@` — private to each object:

```ruby
class User
  def initialize(name, age)
    @name = name      # instance variable
    @age = age        # instance variable
  end
  
  def describe
    "#{@name} is #{@age} years old"
  end
end

user = User.new("Paul", 30)
user.describe  # "Paul is 30 years old"
```

## Attr Accessors (Shorthand)

Instead of writing getters/setters manually:

```ruby
# Verbose:
class Person
  def initialize(name)
    @name = name
  end
  
  def name
    @name
  end
  
  def name=(value)
    @name = value
  end
end

# Better - use attr_accessor:
class Person
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
end

person = Person.new("Paul")
person.name        # read
person.name = "Jo" # write
```

**Three types**:
```ruby
attr_reader :name       # Read only
attr_writer :name       # Write only  
attr_accessor :name     # Both read and write
```

## Methods in Classes

```ruby
class Summary
  attr_reader :text
  
  def initialize(text)
    @text = text
  end
  
  # Instance method (works on one object)
  def long?
    @text.length > 100
  end
  
  # Class method (works on the class itself)
  def self.create_from_file(path)
    text = File.read(path)
    Summary.new(text)
  end
end

# Instance method
summary = Summary.new("some text")
summary.long?  # false

# Class method
summary = Summary.create_from_file("data.txt")
```

## Testing Classes

```ruby
# spec/summary_spec.rb
require 'rspec'
require_relative '../app/summary'

describe 'Summary' do
  it 'initializes with text' do
    summary = Summary.new("Hello")
    expect(summary.text).to eq("Hello")
  end
  
  it 'calculates length' do
    summary = Summary.new("Hello world")
    expect(summary.length).to eq(11)
  end
  
  it 'identifies long summaries' do
    summary = Summary.new("x" * 150)
    expect(summary.long?).to be true
  end
end
```

## Arrays of Objects

```ruby
class Summary
  attr_reader :text
  
  def initialize(text)
    @text = text
  end
  
  def length
    @text.length
  end
end

# Create array of objects
summaries = [
  Summary.new("short"),
  Summary.new("medium length text"),
  Summary.new("x" * 200)
]

# Use them
summaries.map { |s| s.length }
summaries.select { |s| s.length > 50 }
summaries.each { |s| puts s.text }
```

## Common Patterns

**Predicate methods** (return true/false):
```ruby
class Task
  def complete?
    @status == "done"
  end
  
  def empty?
    @items.length == 0
  end
end
```

**Mutation methods** (change state):
```ruby
class List
  def add!(item)      # ! means it mutates
    @items << item
  end
  
  def clear!          # ! means it mutates
    @items = []
  end
end
```

## Mistakes to Avoid

❌ **Forgetting `@` for instance variables**:
```ruby
class User
  def initialize(name)
    name = name  # Wrong! This is local variable
    @name = name # Right!
  end
end
```

❌ **Using instance variables without initialize**:
```ruby
class User
  def describe
    @name  # Might be nil if not set in initialize
  end
end
```

---

**Remember**: Classes organize data and behavior. Each class should have one clear responsibility.
