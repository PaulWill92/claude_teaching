# ============================================================
# PROJECT: Number Guessing Game
# ============================================================
# SUMMARY:
#   The computer picks a random number between 1 and 100.
#   The player keeps guessing until they find it.
#   After each wrong guess, give a "too high" or "too low" hint.
#   When they guess correctly, tell them how many attempts it took.
#
# CONCEPTS: rand, while loops, gets.chomp.to_i, string interpolation,
#           counters (attempts += 1), conditionals
# ============================================================

# STEP 1 ─────────────────────────────────────────────────────
# Generate a random number between 1 and 100.
# Hint: rand(100) gives 0-99. How would you shift that to 1-100?
# Store it in a variable called `secret_number`.



# STEP 2 ─────────────────────────────────────────────────────
# Create an `attempts` counter starting at 0.
# You'll add 1 to it each time the player guesses.



# STEP 3 ─────────────────────────────────────────────────────
# Welcome the player. Print something like:
#   "I've picked a number between 1 and 100. Can you guess it?"



# STEP 4 ─────────────────────────────────────────────────────
# Ask for the first guess BEFORE the loop so you have something to compare.
# Use gets.chomp.to_i to convert the input string to an integer.
# Store it in `guess`.



# STEP 5 ─────────────────────────────────────────────────────
# Write a `while` loop that keeps running while guess != secret_number.
# Inside the loop:
#   a) Increment attempts by 1
#   b) Check if guess is too high or too low and print a hint
#   c) Ask for a new guess and update the `guess` variable
#
# while guess != secret_number
#   ...
# end



# STEP 6 ─────────────────────────────────────────────────────
# After the loop exits, the player has guessed correctly.
# Don't forget to count this final attempt too (attempts += 1).
# Print a congratulations message that includes:
#   - The secret number
#   - How many attempts it took
# Example: "Correct! The number was 42. You got it in 5 attempts."



# ─── STRETCH GOALS (tackle after the basic version works) ────
# 1. Add a difficulty menu before the game starts:
#      Easy = 1-10, Medium = 1-50, Hard = 1-100
#    Use the player's choice to set the range for rand.
#
# 2. Give the player a limited number of guesses (e.g. 7).
#    If they run out, reveal the number and end the game.
#
# 3. After the game ends, ask "Play again? (y/n)".
#    If they say y, restart everything. Hint: wrap the whole game in a loop.
