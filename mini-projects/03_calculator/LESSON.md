# Project 3: Calculator

## What You'll Build
A calculator that asks for two numbers and an operation (+, -, *, /), performs the calculation, prints the result, and asks if the user wants to calculate again. Operations are handled by separate methods.

---

## Concepts You'll Practice

### Defining methods (`def`)
Break logic into named, reusable pieces. Each operation gets its own method.

```ruby
def add(a, b)
  a + b
end

result = add(5, 3)  # => 8
```

### `.to_f` vs `.to_i`
`.to_i` gives whole numbers. `.to_f` gives floats (decimals). Use `.to_f` here so `5 / 2` gives `2.5` not `2`.

```ruby
num = gets.chomp.to_f
```

### Division by zero
A real edge case to handle. In Ruby, dividing an integer by zero raises an error. Check for it before dividing.

```ruby
if b == 0
  puts "Can't divide by zero"
else
  a / b
end
```

### Returning values from methods
Ruby methods automatically return the last evaluated expression. You can also use `return` explicitly.

```ruby
def multiply(a, b)
  a * b          # this is returned automatically
end
```

### Rounding output
`.round(2)` limits a float to 2 decimal places — keeps output clean.

```ruby
puts result.round(2)
```

---

## Ruby Things to Notice

- Method names use `snake_case` by convention (like Python)
- A method that asks a yes/no question is often named with a `?` e.g. `valid_input?` — Ruby convention
- You can pass a method's return value directly into `puts`: `puts add(2, 3)`

---

## Stretch Goals
1. Add modulo (`%`) and exponent (`**`) operations
2. Keep a running history of calculations and print them at the end
3. Validate that the input is actually a number (hint: try `.match?(/\A-?\d+(\.\d+)?\z/)`)
