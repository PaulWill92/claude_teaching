# Conditionals and Logic Reference

Control flow: if/elsif/else, boolean logic, and ternary operators.

## If/Elsif/Else

### Basic Structure

```ruby
if condition
  # code runs if true
elsif other_condition
  # code runs if first was false, this is true
else
  # code runs if none above were true
end
```

### Examples

```ruby
age = 25

if age < 13
  puts "Child"
elsif age < 18
  puts "Teenager"
elsif age < 65
  puts "Adult"
else
  puts "Senior"
end
```

```ruby
score = 85

if score >= 90
  grade = "A"
elsif score >= 80
  grade = "B"
elsif score >= 70
  grade = "C"
else
  grade = "F"
end
```

## Boolean Operators

### OR (`||`)

True if **either** condition is true:

```ruby
if age < 13 || age > 65
  puts "Special pricing"
end

# More readable version
if young? || senior?
  apply_discount
end
```

### AND (`&&`)

True if **both** conditions are true:

```ruby
if age >= 18 && has_license?
  can_drive = true
end

# With multiple conditions
if status == "active" && payment_received && !expired?
  process_order
end
```

### NOT (`!`)

Inverts true/false:

```ruby
if !empty?
  process_data
end

# More readable
unless empty?
  process_data
end
```

## Order of Operations

```ruby
# AND has higher priority than OR
if a || b && c
  # Read as: a OR (b AND c)
end

# Use parentheses to be explicit
if (a || b) && c
  # Read as: (a OR b) AND c
end
```

## Ternary Operator (Shorthand If)

```ruby
# Long form
if age >= 18
  status = "adult"
else
  status = "minor"
end

# Ternary form
status = age >= 18 ? "adult" : "minor"

# Multiple ternary (not recommended, gets hard to read)
grade = score >= 90 ? "A" : score >= 80 ? "B" : "C"
```

## Inline If/Unless

```ruby
# Inline if
puts "Valid!" if age >= 18

# Inline unless
puts "Too young" unless age >= 18

# These are same as:
if age >= 18
  puts "Valid!"
end
```

## Truthiness in Ruby

**Truthy** (treated as true):
- Everything except `false` and `nil`
- Numbers: `1`, `0`, `-1` (all truthy!)
- Strings: `"hello"`, `""` (even empty string!)
- Arrays: `[]` (even empty!)

**Falsy** (treated as false):
- `false`
- `nil`

### Common Mistake:

```ruby
if number
  puts "Number exists"
end

# This is truthy for 0! (Different from Python)
# number = 0 → runs the code
```

## Case/When (Switch Alternative)

```ruby
day = 3

case day
when 1
  puts "Monday"
when 2
  puts "Tuesday"
when 3
  puts "Wednesday"
else
  puts "Other day"
end

# With ranges
case age
when 0..12
  puts "Child"
when 13..19
  puts "Teen"
when 20..64
  puts "Adult"
else
  puts "Senior"
end
```

## Testing Conditions

```ruby
require 'rspec'

describe 'age validation' do
  it 'identifies adults' do
    age = 25
    expect(age >= 18).to be true
  end
  
  it 'identifies minors' do
    age = 15
    expect(age >= 18).to be false
  end
  
  it 'checks multiple conditions' do
    age = 25
    has_license = true
    expect(age >= 18 && has_license).to be true
  end
end
```

## Conditional in Filtering

```ruby
# Filter using condition
data = [10, 5, 20, 3, 15]

# Keep numbers > 10
large = data.select { |n| n > 10 }
# [20, 15]

# Keep numbers between 5 and 15
medium = data.select { |n| n >= 5 && n <= 15 }
# [10, 5, 15]

# Keep anything NOT 10
not_ten = data.select { |n| n != 10 }
# [5, 20, 3, 15]
```

## Predicates (Methods Returning True/False)

```ruby
class User
  def adult?
    age >= 18
  end
  
  def premium?
    subscription == "premium"
  end
  
  def valid?
    !email.empty? && !name.empty?
  end
end

user = User.new("Paul", 30)

if user.adult? && user.premium?
  grant_access
end
```

## Guard Clauses

Early exit pattern (cleaner than nested ifs):

```ruby
# Nested (hard to read)
def process_order(order)
  if order.valid?
    if order.total > 0
      if user.has_payment?
        # ... 20 lines of logic
      end
    end
  end
end

# Guard clauses (clean)
def process_order(order)
  return nil unless order.valid?
  return nil if order.total <= 0
  return nil unless user.has_payment?
  
  # ... 20 lines of logic
end
```

## Chaining Conditions

```ruby
# Long
if age >= 18 && status == "active" && !banned? && has_credit?
  approve_request
end

# More readable with helper methods
if eligible_for_approval?
  approve_request
end

def eligible_for_approval?
  age >= 18 && 
    status == "active" && 
    !banned? && 
    has_credit?
end
```

## Common Mistakes

❌ **Confusing = (assign) with == (compare)**:
```ruby
if name = "Paul"    # Wrong! Always true, assigns name
  # ...
end

if name == "Paul"   # Right! Compares
  # ...
end
```

❌ **Forgetting && or ||**:
```ruby
if age > 18 age < 65  # Wrong! Syntax error
  # ...
end

if age > 18 && age < 65  # Right!
  # ...
end
```

❌ **Checking empty incorrectly**:
```ruby
data = []

if data            # True! Empty array is truthy
  puts "has data"
end

if data.empty?     # Better
  puts "no data"
end
```

## Quick Reference Table

| Operator | Meaning | Example |
|----------|---------|---------|
| `==` | Equal | `age == 25` |
| `!=` | Not equal | `name != "Paul"` |
| `>` | Greater than | `age > 18` |
| `<` | Less than | `age < 65` |
| `>=` | Greater or equal | `age >= 18` |
| `<=` | Less or equal | `age <= 100` |
| `&&` | AND | `age > 18 && has_id` |
| `\|\|` | OR | `admin \|\| owner` |
| `!` | NOT | `!empty?` |
| `?:` | Ternary | `active ? "yes" : "no"` |

---

**Remember**: Keep conditions simple. If they get complex, extract into a helper method with a clear name.
