# ============================================================
# PROJECT: Contact Book
# ============================================================
# SUMMARY:
#   A menu-driven contact book. The user can:
#     1. Add a contact (name, phone, email)
#     2. List all contacts
#     3. Search contacts by name
#     4. Delete a contact
#     5. Quit
#   Contacts are stored as hashes inside an array.
#   This project combines everything from the previous four.
#
# CONCEPTS: array of hashes, symbols as keys, select, find,
#           delete_if, methods with parameters, nil checks,
#           each with formatted output
# ============================================================

# STEP 1 ─────────────────────────────────────────────────────
# Create an empty array called `contacts`.



# STEP 2 ─────────────────────────────────────────────────────
# Define a method `add_contact(contacts)` that:
#   - Asks for name, phone, and email (three separate gets.chomp calls)
#   - Builds a hash like: { name: "Alice", phone: "...", email: "..." }
#   - Pushes it to the contacts array
#   - Prints "Contact saved!"
#
# Note: use Symbol keys (:name, :phone, :email) not strings.



# STEP 3 ─────────────────────────────────────────────────────
# Define a method `list_contacts(contacts)` that:
#   - If contacts is empty, prints "No contacts saved." and returns
#   - Otherwise loops through each contact with each_with_index and prints:
#
#       1. Alice
#          Phone: 07700 123456
#          Email: alice@example.com
#          ──────────────────────
#
# Hint: use "─" * 22 for the divider line.



# STEP 4 ─────────────────────────────────────────────────────
# Define a method `search_contacts(contacts)` that:
#   - Asks: "Search by name:"
#   - Uses select to find contacts where name includes the query (case-insensitive)
#     results = contacts.select { |c| c[:name].downcase.include?(query.downcase) }
#   - If results is empty, prints "No contacts found."
#   - Otherwise calls list_contacts(results) to display them
#     (reusing the method you already wrote)



# STEP 5 ─────────────────────────────────────────────────────
# Define a method `delete_contact(contacts)` that:
#   - Calls list_contacts(contacts) to show the numbered list
#   - Asks: "Enter contact number to delete (or 0 to cancel):"
#   - Converts input to integer
#   - If 0, print "Cancelled." and return
#   - Otherwise use delete_at(index - 1) to remove the contact
#   - Print "Contact deleted."
#   - Handle the case where the number is out of range.



# STEP 6 ─────────────────────────────────────────────────────
# Print a welcome banner, then write the main `loop do ... end`.
#
# Each iteration:
#   a) Print the menu:
#        "1. Add contact"
#        "2. List contacts"
#        "3. Search contacts"
#        "4. Delete contact"
#        "5. Quit"
#
#   b) Read the user's choice.
#
#   c) Use case/when to call the right method, passing `contacts` as an argument.
#      when "5": print "Goodbye!" and break.
#      else: print "Invalid option."



# ─── STRETCH GOALS ───────────────────────────────────────────
# 1. Save and load contacts using CSV.
#    require 'csv'
#    Load on startup: read each row into a hash and push to contacts.
#    Save after every change: write all contacts to the CSV file.
#
# 2. Validate email format before saving.
#    A simple check: email.include?("@") && email.include?(".")
#    A stricter check uses a regex: email.match?(/\A[^@]+@[^@]+\.[^@]+\z/)
#
# 3. Add an "Edit contact" option (option 5, push Quit to 6).
#    Show the current values, let the user re-enter each field,
#    and update the hash in place.
#
# 4. Sort contacts alphabetically when listing.
#    Hint: contacts.sort_by { |c| c[:name] }.each_with_index { ... }
