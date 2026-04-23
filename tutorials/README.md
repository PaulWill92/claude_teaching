# Ruby Learning Tutorials

Self-contained tutorial files for learning Ruby concepts before building projects.

## Structure

```
tutorials/
├── phase_3_classes_and_web_scraping/
│   ├── classes_tutorial.rb           # OOP fundamentals, inheritance
│   ├── http_requests_tutorial.rb     # Fetching data from web
│   ├── nokogiri_tutorial.rb          # Parsing HTML
│   ├── error_handling_tutorial.rb    # Exceptions and recovery
│   ├── practice_scenarios.rb         # 10 progressive scenarios
│   └── README.md                     # How to use with IRB + splits
│
└── phase_4_rails_concepts/
    ├── service_objects_intro.rb      # Basic service object pattern
    ├── service_objects_intermediate.rb # Error handling & validation
    ├── service_objects_advanced.rb   # Composition & orchestration
    ├── service_objects_practice.rb   # 6 realistic scenarios
    └── README.md                     # Guide & progression
```

## How to Use: Split Window + IRB Workflow

This is the recommended way to learn. You'll read code in one window and run it in another.

### Step 1: Open Tutorial in Split (lazyvim)

```bash
cd ~/Documents/GitHub/learning/ruby/claude_teaching
nvim tutorials/phase_3_classes_and_web_scraping/
```

This opens nvim in the tutorials folder.

### Step 2: Open Tutorial File (Right Side)

From nvim:
```
leader + ff    # Fuzzy find
type: classes_tutorial.rb
press enter    # Opens in right split
```

### Step 3: Open IRB in Left Split

```
ctrl + v       # Split vertically (creates left side)
ctrl + h       # Move to left split
:terminal      # Open terminal in left split
irb            # Start interactive Ruby
```

Now you have:
```
┌─────────────────────────────┐
│ IRB (left)  │ Tutorial (right) │
│             │                  │
│ >> code     │ # Classes tutorial│
│             │ class Person     │
│             │   def initialize │
└─────────────────────────────┘
```

### Step 4: Learn and Code

Read a section in the right side, then:

1. Copy the code snippet (visually select, `y` to copy)
2. Switch to left split: `ctrl + h`
3. Paste in IRB: `ctrl + shift + v` or just type
4. Run it: `enter`
5. See results immediately
6. Switch back to read next section: `ctrl + l`

### Example Workflow

**Right split (tutorial shows):**
```ruby
class Dog
  def initialize(name, breed)
    @name = name
    @breed = breed
  end

  def bark
    puts "#{@name} says woof!"
  end
end
```

**Left split (IRB):**
```
>> class Dog
?>   def initialize(name, breed)
?>     @name = name
?>     @breed = breed
?>   end
?>   def bark
?>     puts "#{@name} says woof!"
?>   end
>> end
=> nil

>> dog = Dog.new("Buddy", "Golden Retriever")
=> #<Dog:0x...>

>> dog.bark
Buddy says woof!
=> nil
```

Then continue reading the tutorial for the next concept.

## Keybindings Reference

| Action | Keys |
|--------|------|
| Split vertically | `ctrl + v` |
| Move to left split | `ctrl + h` |
| Move to right split | `ctrl + l` |
| Open terminal | `:terminal` |
| Exit terminal | `:exit` or `ctrl + d` |
| Search in file | `leader + ff` |
| Toggle file tree | `ctrl + h` (in normal mode, outside terminal) |

## Tips for Success

**1. Uncomment as You Go**
Tutorial files have lots of commented examples. As you read:
- Uncomment relevant sections
- Run them in IRB
- Modify them to test understanding
- Comment back out when done

**2. Use pry for Debugging**
Add `binding.pry` to any code in IRB:
```ruby
# Type in IRB:
def my_function(x)
  binding.pry  # Pauses here
  x * 2
end

my_function(5)
# Drops into pry, you can inspect x, step through, continue with 'exit'
```

**3. Test Edge Cases**
After running an example:
```ruby
# Tutorial showed:
result = [1, 2, 3].select { |n| n > 2 }

# Test edge case:
result = [].select { |n| n > 2 }  # Empty array
result = [5].select { |n| n > 2 }  # Single element
```

**4. Read Error Messages**
When something fails in IRB, read the error carefully. Use it to understand what went wrong.

## Working Through a Tutorial

### Full Workflow Example

1. **Start fresh**
   ```bash
   cd learning/ruby/claude_teaching
   nvim tutorials/phase_3_classes_and_web_scraping/
   ```

2. **Open tutorial in right split**
   - `leader + ff`
   - Type `classes`
   - Open `classes_tutorial.rb`

3. **Open IRB in left split**
   - `ctrl + v` (split)
   - `ctrl + h` (move left)
   - `:terminal`
   - `irb`

4. **Read Section 1: What is a Class**
   - Read the example code on right
   - It shows a Python example → Ruby example
   - Type or paste the Ruby class into IRB

5. **Experiment**
   - Create an instance: `person = Person.new("Paul", 30)`
   - Call methods on it
   - Modify the code in IRB to test understanding

6. **Move to next section**
   - Read section in right split
   - Test code in left split with IRB
   - Repeat

7. **Practice exercises at end**
   - After learning all concepts
   - Try the practice exercises
   - Use pry if you get stuck

## Files Overview

### classes_tutorial.rb
**What you'll learn:** Classes, instance variables, methods, inheritance, private methods, error handling

**Time:** 30-45 minutes to read + code along

**Prerequisites:** Comfortable with functions, conditionals, arrays

### http_requests_tutorial.rb
**What you'll learn:** Fetching web pages, error handling, retries, headers, status codes

**Time:** 20-30 minutes to read + code along

**Prerequisites:** Understanding of functions, begin/rescue/end

**Note:** Examples show both Net::HTTP (lower level) and OpenURI (simpler). Focus on OpenURI.

### nokogiri_tutorial.rb
**What you'll learn:** Parsing HTML, CSS selectors, extracting data, handling missing elements

**Time:** 25-35 minutes to read + code along

**Prerequisites:** HTTP requests (to fetch HTML), basic method chaining

### error_handling_tutorial.rb
**What you'll learn:** begin/rescue/end, raising errors, custom exceptions, retry logic, best practices

**Time:** 20-30 minutes to read + code along

**Prerequisites:** Basic classes and method calls

### practice_scenarios.rb
**What you'll learn:** Building toward the Web Scraper project through 10 progressive challenges

**Time:** 45-60 minutes (do all 10 scenarios)

**Prerequisites:** All 4 tutorials above

## Order to Work Through

1. **classes_tutorial.rb** ← Start here
2. **error_handling_tutorial.rb** ← Learn error handling before fetching
3. **http_requests_tutorial.rb** ← Fetch web pages
4. **nokogiri_tutorial.rb** ← Parse what you fetched
5. **practice_scenarios.rb** ← Build it all together

This order builds progressively toward Project 2b (Web Scraper).

## Using pry Instead of IRB

If you prefer pry:

```bash
gem install pry          # One time setup
pry                      # Instead of irb
```

pry is similar to IRB but with some nice extras (better colors, shell integration, better history).

## Stuck?

If something doesn't work:

1. **Read the error message** — it usually tells you exactly what's wrong
2. **Search the referenced resource** — each tutorial has links at top
3. **Try a simpler example first** — reduce complexity to isolate the problem
4. **Use pry with `binding.pry`** — pause execution and inspect variables
5. **Ask Claude** — show the error and what you tried

## Phase 4: Rails Concepts (Service Objects)

After Project 2b (Web Scraper) and learning Rails basics, you'll move to Phase 4 tutorials.

**Service Objects Tutorial Progression:**
1. `service_objects_intro.rb` — Basic pattern (25-35 min)
2. `service_objects_intermediate.rb` — Error handling (30-40 min)
3. `service_objects_advanced.rb` — Composition & orchestration (35-45 min)
4. `service_objects_practice.rb` — 6 realistic scenarios (45-60 min)

See `phase_4_rails_concepts/README.md` for detailed guide.

## Next Steps After Tutorials

### After Phase 3 (Classes & Web Scraping)
**You're ready for Project 2b: Web Scraper**

The project brings all these concepts together:
- Classes (base scraper, subclasses)
- HTTP requests (fetching pages)
- Error handling (network failures, parsing errors)
- Nokogiri (extracting data)
- File I/O (saving results)

### After Project 2b
**Move to Rails Basics and Phase 4: Service Objects**

Learn professional patterns for organizing business logic before building your first Rails app.

### After Phase 4
**You're ready for Phase 5: Real Rails Project**

Build a complete Rails application using all the patterns and concepts you've learned.

---

**Happy learning! Code along as you read.** 🚀
