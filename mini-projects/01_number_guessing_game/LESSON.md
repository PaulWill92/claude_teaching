# Project 1: Number Guessing Game

## What You'll Build
A game where the computer picks a random number between 1 and 100, and the player guesses until they get it right. After each guess the player is told if they're too high, too low, or correct. At the end, the number of attempts is shown.

---

## Concepts You'll Practice

### `rand`
Generates a random number. `rand(100)` gives 0–99, so `rand(100) + 1` gives 1–100.

```ruby
secret = rand(100) + 1
```

### `gets.chomp.to_i`
You've used `gets.chomp` to get string input. `.to_i` converts that string to an integer so you can do math with it.

```ruby
guess = gets.chomp.to_i
```

### `while` loops
Keeps looping as long as a condition is true. Perfect for "keep asking until they get it right."

```ruby
while guess != secret
  # ask again
end
```

### Counting with a variable
Increment a counter each loop to track how many attempts were made.

```ruby
attempts = 0
attempts += 1  # same as: attempts = attempts + 1
```

### `if / elsif / else`
You've already done this — here you'll use it to give directional hints.

---

## Ruby Things to Notice

- `puts` adds a newline; `print` does not (useful if you want input on the same line)
- String interpolation: `"You guessed #{guess}"` — the `#{}` injects a variable into a string
- `.to_i` on a non-number string returns `0` — worth knowing for edge cases

---

## Stretch Goals (once the basic version works)
1. Add a difficulty setting: Easy (1–10), Medium (1–50), Hard (1–100)
2. Limit the player to a maximum number of guesses
3. After the game ends, ask "play again?" and loop if they say yes
