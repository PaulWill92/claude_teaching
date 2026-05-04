# Project 5: Contact Book

## What You'll Build
A menu-driven contact book where the user can add contacts (name + phone + email), list all contacts, search by name, and delete a contact. Contacts are stored as hashes inside an array.

This is the most complex project in the set — it combines everything from the previous four.

---

## Concepts You'll Practice

### Array of hashes
The natural way to represent a list of structured records in Ruby.

```ruby
contacts = []

contact = {
  name: "Alice",
  phone: "07700 123456",
  email: "alice@example.com"
}

contacts << contact
contacts[0][:name]   # => "Alice"
```

Note: `:name` is a Symbol (like a lightweight string used as a key). More efficient than string keys for hashes.

### `select` — filtering arrays
Returns a new array containing only elements where the block returns true.

```ruby
results = contacts.select { |c| c[:name].downcase.include?(query.downcase) }
```

### `find` — finding one item
Like `select` but stops at the first match and returns that item (or `nil`).

```ruby
contact = contacts.find { |c| c[:name] == "Alice" }
```

### `delete_if`
Removes elements from an array in place where the block returns true.

```ruby
contacts.delete_if { |c| c[:name] == "Alice" }
```

### Methods that take the contacts array as a parameter
Organise your code into methods. Pass `contacts` in as a parameter so your methods are self-contained.

```ruby
def add_contact(contacts)
  # prompt, build hash, push to contacts
end

def list_contacts(contacts)
  # print each contact
end
```

### Formatting output
Use string interpolation and padding to make output readable.

```ruby
puts "Name:  #{contact[:name]}"
puts "Phone: #{contact[:phone]}"
puts "Email: #{contact[:email]}"
puts "-" * 30
```

---

## Ruby Things to Notice

- Symbols (`:name`) vs strings (`"name"`) as hash keys — Symbols are the Ruby convention for fixed keys
- `nil` is Ruby's null — methods like `find` return `nil` when nothing matches, so always check
- `puts ""` prints a blank line — useful for spacing output

---

## Stretch Goals
1. Save contacts to a CSV file and load them on startup (`require 'csv'`)
2. Validate email format with a simple regex before saving
3. Add an edit/update contact feature
4. Sort contacts alphabetically when listing
