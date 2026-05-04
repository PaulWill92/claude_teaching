# ============================================================
# PROJECT: Simple To-Do List
# ============================================================
# SUMMARY:
#   A menu-driven app where the user can:
#     1. Add a task
#     2. View all tasks (numbered)
#     3. Remove a task by number
#     4. Quit
#   Tasks live in an array. The menu loops until the user quits.
#
# CONCEPTS: arrays, loop/break, each_with_index, case/when,
#           gets.chomp, .to_i, guard clauses with next
# ============================================================

# STEP 1 ─────────────────────────────────────────────────────
# Create an empty array called `tasks` to store the to-do items.



# STEP 2 ─────────────────────────────────────────────────────
# Print a welcome message.



# STEP 3 ─────────────────────────────────────────────────────
# Write the main menu loop using `loop do ... end`.
# Inside the loop, print the menu options every iteration:
#
#   "─────────────────"
#   "1. Add task"
#   "2. View tasks"
#   "3. Remove task"
#   "4. Quit"
#   "─────────────────"
#
# Then capture the user's choice with gets.chomp.



# STEP 4 ─────────────────────────────────────────────────────
# Inside the loop, use `case choice` to handle each option.
#
# when "1" → Add a task
#   Ask: "Enter task:"
#   Read input, push it to the tasks array.
#   Confirm: "Task added!"
#
# when "2" → View tasks
#   If tasks is empty, print "No tasks yet!" and use `next` to skip.
#   Otherwise loop through tasks with each_with_index and print:
#     "1. Buy milk"
#     "2. Call dentist"
#
# when "3" → Remove a task
#   If tasks is empty, print "No tasks to remove!" and `next`.
#   Otherwise show the tasks (same as view), ask "Which task number?"
#   Convert input to integer, subtract 1 to get the array index.
#   Use delete_at to remove it. Confirm removal.
#
# when "4" → Quit
#   Print "Goodbye!" and use `break` to exit the loop.
#
# else → handle unexpected input
#   Print "Invalid choice, try again."



# ─── STRETCH GOALS ───────────────────────────────────────────
# 1. Save tasks to a file (tasks.txt) so they persist.
#    On startup: load tasks from the file if it exists.
#    After every change: write the current tasks array to the file.
#    Hint: File.write("tasks.txt", tasks.join("\n"))
#          tasks = File.readlines("tasks.txt", chomp: true) rescue []
#
# 2. Instead of deleting tasks, mark them done with a [x] prefix.
#    Add a 5th menu option: "Mark task done".
#
# 3. Add a "clear all" option that empties the array after confirmation.
