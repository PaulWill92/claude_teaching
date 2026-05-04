# ============================================================
# PROJECT: Calculator
# ============================================================
# SUMMARY:
#   Ask the user for two numbers and an operator (+, -, *, /).
#   Each operation is handled by its own method.
#   Print the result, then ask if they want to calculate again.
#
# CONCEPTS: def methods, return values, .to_f, case/when,
#           division by zero edge case, .round(2), loop/break
# ============================================================

# STEP 1 ─────────────────────────────────────────────────────
# Define four methods: add, subtract, multiply, divide.
# Each takes two parameters (a, b) and returns the result.
#
# For `divide`, handle division by zero:
#   if b == 0, return the string "Error: can't divide by zero"
#   otherwise return a / b
#
# def add(a, b)
#   ...
# end



# STEP 2 ─────────────────────────────────────────────────────
# Define a method called `get_number(prompt)` that:
#   - Prints the prompt string
#   - Reads input with gets.chomp
#   - Converts it to a float with .to_f
#   - Returns the float
#
# This avoids repeating the same input logic twice.



# STEP 3 ─────────────────────────────────────────────────────
# Define a method called `get_operator` that:
#   - Prints "Enter operator (+, -, *, /):"
#   - Reads and returns the input (just gets.chomp, no conversion needed)



# STEP 4 ─────────────────────────────────────────────────────
# Print a welcome message: "Simple Calculator"



# STEP 5 ─────────────────────────────────────────────────────
# Write the main `loop do ... end`.
# Inside each iteration:
#
#   a) Call get_number to get the first number (store as `a`)
#   b) Call get_operator to get the operator (store as `op`)
#   c) Call get_number to get the second number (store as `b`)
#
#   d) Use `case op` to call the right method and store the result.
#      when "+" → add(a, b)
#      when "-" → subtract(a, b)
#      when "*" → multiply(a, b)
#      when "/" → divide(a, b)
#      else → "Unknown operator"
#
#   e) Print the result. If it's a Float, use .round(2) to limit decimals.
#      Example: "5.0 + 3.0 = 8.0"
#
#   f) Ask "Calculate again? (y/n)". Break the loop if they say "n".



# ─── STRETCH GOALS ───────────────────────────────────────────
# 1. Add modulo (%) and exponent (**) operations.
#
# 2. Keep a history array. After each calculation push a summary string
#    like "5.0 + 3.0 = 8.0" to it. When the user quits, print the history.
#
# 3. Validate that input is actually a number before converting.
#    If the user types "abc", .to_f returns 0.0 silently — that's a bug.
#    Hint: check if the input matches /\A-?\d+(\.\d+)?\z/ before converting.
