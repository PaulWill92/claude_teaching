# Project 2: Simple To-Do List

## What You'll Build
A menu-driven command-line app where the user can add tasks, view all tasks, remove a task by number, and quit. Everything lives in memory (no file saving yet — that's a stretch goal).

---

## Concepts You'll Practice

### Arrays
An ordered list of items. The backbone of this project.

```ruby
tasks = []           # empty array
tasks << "Buy milk"  # add to end (same as tasks.push("Buy milk"))
tasks[0]             # access first item (index starts at 0)
tasks.length         # how many items
tasks.delete_at(0)   # remove item at index 0
```

### `loop do ... end`
An infinite loop you exit with `break`. Good for menus where you keep showing options until the user quits.

```ruby
loop do
  puts "1. Add  2. View  3. Remove  4. Quit"
  choice = gets.chomp
  break if choice == "4"
end
```

### `each` with index
When displaying a list, you often want the number alongside the item.

```ruby
tasks.each_with_index do |task, index|
  puts "#{index + 1}. #{task}"
end
```

### `case / when`
A cleaner alternative to long `if/elsif` chains — great for menu handling.

```ruby
case choice
when "1"
  # add task
when "2"
  # view tasks
when "3"
  # remove task
end
```

### Guard clauses
Check for empty state before doing something, and exit early.

```ruby
if tasks.empty?
  puts "No tasks yet!"
  next  # skip the rest of this loop iteration
end
```

---

## Ruby Things to Notice

- Arrays are zero-indexed, but humans count from 1 — you'll bridge this with `index + 1` for display and `input.to_i - 1` when the user picks a number
- `next` inside a loop skips to the next iteration (like Python's `continue`)
- `break` exits the loop entirely

---

## Stretch Goals
1. Save tasks to a `.txt` file so they persist between runs (`File.write`, `File.readlines`)
2. Mark tasks as done instead of deleting them (add a `[x]` prefix)
3. Add a "clear all" option
