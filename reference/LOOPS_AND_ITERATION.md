# Loops and Iteration in Ruby

This file covers Ruby loops and iteration methods. Search: "loops", "iteration", "each", "map", "select"

---

## Ruby Doesn't Have Traditional Loops

Ruby doesn't have `for` loops like Python. Instead, use **iterator methods**:

### .each — Loop Over All Elements

```ruby
[1, 2, 3].each { |n| puts n }
# Output: 1, 2, 3

# Or with do...end for multi-line
[1, 2, 3].each do |n|
  puts "Number: #{n}"
end
```

### .times — Repeat N Times

```ruby
5.times { |i| puts i }  # i = 0, 1, 2, 3, 4
# Or:
5.times do |i|
  puts "Loop iteration #{i}"
end
```

### .map — Transform Each Element

```ruby
numbers = [1, 2, 3]
doubled = numbers.map { |n| n * 2 }
# => [2, 4, 6]
```

### .select — Filter Elements

```ruby
numbers = [1, 2, 3, 4, 5]
evens = numbers.select { |n| n.even? }
# => [2, 4]
```

### .upto and .downto — Numeric Ranges

```ruby
1.upto(5) { |i| puts i }      # 1, 2, 3, 4, 5
5.downto(1) { |i| puts i }    # 5, 4, 3, 2, 1
```

### .step — Loop with Step Size

```ruby
0.step(10, 2) { |i| puts i }  # 0, 2, 4, 6, 8, 10
```

### Hash Iteration

```ruby
person = { name: "Paul", age: 30 }
person.each { |key, value| puts "#{key}: #{value}" }

# Or use .each_key, .each_value
person.each_key { |k| puts k }      # name, age
person.each_value { |v| puts v }    # Paul, 30
```

---

## Common Pattern: Conditional Iteration

```ruby
# Filter AND transform
numbers = [1, 2, 3, 4, 5]
result = numbers
  .select { |n| n > 2 }     # [3, 4, 5]
  .map { |n| n * 10 }       # [30, 40, 50]

# This is more Rubyish than traditional loops
```

---

## When to Use Which

| Task | Method |
|------|--------|
| Loop N times | `.times` |
| Loop over collection | `.each` |
| Transform collection | `.map` |
| Filter collection | `.select` |
| Count matching items | `.count { condition }` |
| Find first match | `.find { condition }` |
| Check all match | `.all? { condition }` |
| Check any match | `.any? { condition }` |

---

See also: [ITERATION_AND_BLOCKS.md](./ITERATION_AND_BLOCKS.md)
