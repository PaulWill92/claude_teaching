# Classes Tutorial: Building Reusable Objects
# Learn how to model real-world concepts as Ruby classes
# Compares to Python classes (which you know)

# Resources:
# - Ruby Classes: https://ruby-doc.org/docs/ruby-doc-bundle/FAQ/FAQ.html#classes
# - Class Definition: https://ruby-doc.org/core/Class.html
# - attr_accessor: Search "Ruby attr_accessor" on ruby-doc.org
# - Inheritance: Search "Ruby inheritance" on ruby-doc.org
# - Private Methods: Search "Ruby private methods" on ruby-doc.org

# ============================================================================
# 1. WHAT IS A CLASS?
# ============================================================================

# In Python:
#   class Person:
#       def __init__(self, name, age):
#           self.name = name
#           self.age = age

# In Ruby:
class Person
  def initialize(name, age)
    @name = name
    @age = age
  end
end

# Key differences:
# - def __init__ → def initialize
# - self.name = name → @name = name (@ marks instance variable)
# - Indentation matters, but Ruby needs 'end' keyword

# ============================================================================
# 2. INSTANCE VARIABLES (@var)
# ============================================================================

class Dog
  def initialize(name, breed)
    @name = name    # Instance variable (belongs to this object)
    @breed = breed
  end

  def bark
    puts "#{@name} says woof!"  # Can use @name inside methods
  end
end

dog = Dog.new("Buddy", "Golden Retriever")
dog.bark  # Output: Buddy says woof!

# ============================================================================
# 3. ATTR ACCESSORS (Read/Write Properties)
# ============================================================================

# Without accessors, you'd write:
class Book
  def initialize(title, author)
    @title = title
    @author = author
  end

  def title
    @title
  end

  def title=(new_title)
    @title = new_title
  end
end

# With accessors (DRY):
class Book
  attr_reader :title        # Read-only (can read, not write)
  attr_writer :author       # Write-only (can write, not read)
  attr_accessor :pages      # Read and write

  def initialize(title, author, pages)
    @title = title
    @author = author
    @pages = pages
  end
end

book = Book.new("1984", "George Orwell", 328)
puts book.title    # Read OK
book.pages = 350   # Write OK
# book.author       # Would fail—only attr_writer, can't read

# ============================================================================
# 4. METHODS IN CLASSES
# ============================================================================

class Rectangle
  attr_accessor :width, :height

  def initialize(width, height)
    @width = width
    @height = height
  end

  # Instance method (operates on one object)
  def area
    @width * @height
  end

  # Predicate method (returns true/false)
  def square?
    @width == @height
  end

  # Class method (operates on the class, not instances)
  def self.from_area(area, aspect_ratio)
    width = Math.sqrt(area * aspect_ratio)
    height = area / width
    new(width, height)
  end
end

rect = Rectangle.new(5, 10)
puts rect.area           # 50
puts rect.square?        # false

rect2 = Rectangle.from_area(100, 1)
puts rect2.width         # 10
puts rect2.height        # 10

# Key difference from Python:
# - Instance methods: def method_name
# - Class methods: def self.method_name (not @classmethod decorator)

# ============================================================================
# 5. INHERITANCE (Extending Classes)
# ============================================================================

# Parent class
class Animal
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} makes a sound"
  end
end

# Child class inherits from Animal
class Cat < Animal
  def speak
    "#{@name} meows"  # Override parent method
  end

  def scratch
    "#{@name} scratches"
  end
end

cat = Cat.new("Whiskers")
puts cat.speak    # Whiskers meows (overridden)
puts cat.scratch  # Whiskers scratches (new method)
puts cat.name     # Whiskers (inherited from Animal)

# ============================================================================
# 6. PRIVATE METHODS (Internal Logic)
# ============================================================================

class BankAccount
  attr_reader :balance

  def initialize(initial_balance)
    @balance = initial_balance
  end

  def deposit(amount)
    validate_amount(amount)
    @balance += amount
  end

  private

  def validate_amount(amount)
    raise "Amount must be positive" if amount <= 0
  end
end

account = BankAccount.new(100)
account.deposit(50)      # OK
# account.validate_amount(50)  # ERROR: private method

# Private methods can only be called from inside the class
# Use them for internal logic that shouldn't be exposed

# ============================================================================
# 7. ERROR HANDLING IN CLASSES
# ============================================================================

class User
  attr_reader :email

  def initialize(email)
    validate_email(email)
    @email = email
  end

  private

  def validate_email(email)
    unless email.include?("@")
      raise ArgumentError, "Invalid email format"
    end
  end
end

begin
  user = User.new("invalid-email")
rescue ArgumentError => e
  puts "Error: #{e.message}"
end

user = User.new("paul@example.com")
puts user.email

# ============================================================================
# 8. PRACTICE: Build a Simple Scraper Class
# ============================================================================

# This previews what you'll do in the Web Scraper project

class SimpleScraper
  attr_reader :url, :data

  def initialize(url)
    @url = url
    @data = []
  end

  def scrape
    fetch_data
    parse_data
    save_data
  end

  private

  def fetch_data
    # Simulate fetching HTML
    @raw_html = "<div class='item'>Item 1</div><div class='item'>Item 2</div>"
  end

  def parse_data
    # Simulate parsing
    @data = ["Item 1", "Item 2"]
  end

  def save_data
    # Simulate saving
    puts "Saved #{@data.length} items"
  end
end

scraper = SimpleScraper.new("https://example.com")
scraper.scrape

# ============================================================================
# KEY CONCEPTS SUMMARY
# ============================================================================

# 1. initialize = constructor (runs when you call .new)
# 2. @var = instance variable (unique to each object)
# 3. attr_reader :var = read-only getter
# 4. attr_writer :var = write-only setter
# 5. attr_accessor :var = read and write
# 6. def method_name = instance method
# 7. def self.method_name = class method
# 8. class Child < Parent = inheritance
# 9. private = hide implementation details
# 10. raise "error" = throw exception

# Python → Ruby translation:
# self.attribute = self.attribute → @attribute
# __init__ → initialize
# def method(self, x): → def method(x)
# @classmethod → def self.method_name

# ============================================================================
# PRACTICE EXERCISES
# ============================================================================

# 1. Create a Student class with name, grade, gpa
#    - Use attr_accessor for all three
#    - Add a method: honors? (returns true if gpa > 3.5)
#    - Test it

# 2. Create a BankAccount class with balance
#    - deposit(amount) adds to balance
#    - withdraw(amount) subtracts from balance
#    - validate_amount(amount) is private and checks > 0
#    - Test withdraw with invalid amount

# 3. Create a Vehicle class with brand and speed
#    - Create Truck < Vehicle with cargo_capacity
#    - Truck can load(pounds) and unload()
#    - Test it

# 4. Try inheritance: create Animal > Dog > Puppy
#    - Each level adds new behavior
#    - Puppy plays(), Dog barks(), Animal sleeps()

puts "\n✓ Classes tutorial complete. Try the practice exercises above."
