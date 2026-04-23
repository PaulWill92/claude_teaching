# Ruby Learning Study Plan

**Goal**: Learn Ruby fundamentals → understand Rails project structure → contribute to real projects

**Your background**: Data scientist (Python/bash) → new Software Engineer  
**Learning style**: Guided discovery (think first, code second)  
**Tools**: mise, lazyvim, Telescope  
**Target skill**: Comfortable reading/writing Rails applications

---

## Parallel Learning Tracks

While learning Ruby, you're simultaneously building **lazyvim mastery**, **GitHub SDLC workflow**, and **testing discipline**. Each project includes acceptance criteria for all three areas, because they're not separate skills—they're how you work as a professional engineer.

### lazyvim Track

**Goal**: Build muscle memory and efficient navigation without touching mouse.

By phase 3, you should be comfortable with:

- Moving between files with Telescope (`leader + ff`, `leader + fg`)
- Splitting windows (`ctrl + v` for vertical, `ctrl + x` for horizontal)
- Navigating within files (hjkl, w/b, /, g followed by keybinding)
- Editing without arrow keys (using standard vim motions)
- Creating new files and directories from within vim
- Finding definitions and references (`leader + sw`, `leader + sr`)

### Testing & Coverage Track

**Goal**: Build the habit of writing tests alongside code; think about verification and coverage.

By phase 3, you should be comfortable with:

- Writing simple tests with RSpec
- Testing individual functions/methods
- Testing edge cases (empty data, nil, single item)
- Understanding test coverage (what % of code is tested)
- Running tests and reading failures
- Understanding why "test as you code" is better than "test after"

**Key mindset**: Before writing code, ask "How would I verify this works?" Then write a test that verifies it. Then write the code that makes the test pass.

## Git/GitHub Track

**Goal**: Practice professional commit discipline and understand SDLC workflow.

By phase 3, you should be comfortable with:

- Creating feature branches: `git checkout -b feature/descriptive-name`
- Making atomic commits: `git commit -m "Clear message about what changed"`
- Viewing history: `git log --oneline`, `git diff`
- Understanding commit messages that tell a story
- Pushing and pulling: `git push origin branch-name`, `git pull`
- Basic PR creation (GitHub web or gh CLI)
- Understanding why commits matter for code review

## Project Setup with Bundler & RuboCop

Before starting **any project**, set up your Ruby environment professionally:

### 1. Create a Gemfile

```bash
cd your-project-directory
bundle init  # Creates Gemfile
```

### 2. Add dependencies to Gemfile

```ruby
# Gemfile
source "https://rubygems.org"

gem "rspec"     # For testing
gem "ruby-lsp"
gem "pry"       # For debugging
gem "rubocop"   # For style enforcement
```

### 3. Install gems

```bash
bundle install  # Installs all gems, creates Gemfile.lock
```

### 4. Run commands with bundler

```bash
bundle exec rspec                 # Run tests
bundle exec rubocop -A            # Auto-fix style issues
bundle exec rubocop               # Check style
bundle exec pry                   # Interactive console
```

### 5. Commit both files

```bash
git add Gemfile Gemfile.lock
git commit -m "Add project dependencies"
```

**Why this matters**: Your company uses bundler and RuboCop. Learning it now means you're practicing exactly how real projects work.

---

### Recommended Git Commands (Cheat Sheet)

| Task | Command | Notes |
|------|---------|-------|
| Create feature branch | `git checkout -b feature/name` | Short, descriptive name |
| See current branch | `git branch` or `git status` | Shows which branch you're on |
| Stage changes | `git add file.rb` | Or `git add .` for all changes |
| Commit with message | `git commit -m "Message"` | First line < 50 chars, imperative mood |
| View commit history | `git log --oneline` | Shows clean history |
| See what changed | `git diff` | Unstaged changes; `git diff --staged` for staged |
| Show specific commit | `git show commit-hash` | View what changed in one commit |
| Push to GitHub | `git push origin branch-name` | First push: `git push -u origin branch-name` |
| Pull latest | `git pull origin main` | Update with upstream changes |
| Switch branches | `git checkout branch-name` | Or `git switch branch-name` (newer) |
| Undo uncommitted changes | `git checkout file.rb` | Careful! This deletes your local changes |
| Amend last commit | `git commit --amend` | Only if not yet pushed |

### Commit Message Formula

**First line** (max 50 characters, imperative):

```
Add CSV loading functionality
Fix filtering logic for long summaries
Refactor Summary class initialization
```

**Body** (explain WHY, not WHAT):

```
The CSV.read method with headers: true makes it easier to access
columns by name instead of index, improving readability.
```

**Example full commit:**

```
Add CSV loading with headers

Using headers: true simplifies downstream code by allowing
column access via row['ColumnName'] instead of row[0].
This makes the code more readable and maintainable.
```

### Why Atomic Commits Matter

Instead of:

```
git commit -m "Finished project"  # 100 files changed, 2000 lines added
```

Do this:

```
git commit -m "Load CSV data"
git commit -m "Add filtering by summary length"
git commit -m "Save results to output files"
```

**Why?** If one commit breaks something, you can identify exactly which change caused it. During code review, it's clear what changed and why.

## Testing & Coverage Track (Detailed)

### RSpec Basics (Testing Framework for Ruby)

**Installation**:

```bash
gem install rspec
rspec --init  # Creates spec directory and .rspec file
```

**Running tests**:

```bash
rspec                          # Run all tests
rspec spec/data_processor_spec.rb  # Run one file
rspec --format documentation   # Prettier output
```

**Basic test structure**:

```ruby
require 'rspec'
require_relative '../data_processor'

describe 'DataProcessor' do
  it 'loads a CSV file correctly' do
    data = DataProcessor.load_csv('./data/test.csv')
    expect(data.length).to eq(3)
  end

  it 'filters data by length' do
    test_data = [
      {'Summary' => 'short'},
      {'Summary' => 'this is a long summary'}
    ]
    result = DataProcessor.filter_long(test_data, 10)
    expect(result.length).to eq(1)
  end

  it 'handles empty data gracefully' do
    result = DataProcessor.filter_long([], 100)
    expect(result).to eq([])
  end
end
```

### Common RSpec Matchers

| Matcher | Example | Meaning |
|---------|---------|---------|
| `eq` | `expect(x).to eq(5)` | Equals |
| `be_nil` | `expect(x).to be_nil` | Is nil |
| `be_empty` | `expect(arr).to be_empty` | Array/string is empty |
| `include` | `expect(arr).to include(5)` | Array includes element |
| `raise_error` | `expect { code }.to raise_error` | Code raises error |
| `start_with` | `expect(str).to start_with('a')` | String starts with |
| `be_truthy` | `expect(x).to be_truthy` | Is truthy (not nil/false) |

### Test Coverage

**Goal**: Know which code is tested.

```bash
# With simplecov (tracks coverage)
gem install simplecov

# In your test file:
require 'simplecov'
SimpleCov.start

# After running tests, open coverage/index.html to see report
```

**Coverage target**: 80%+ for production code (100% is nice, not necessary)

### Writing Testable Code

**Good (testable) code**:

```ruby
def filter_long(data, min_length)
  data.select { |row| row['Summary'].length > min_length }
end

# Easy to test:
result = filter_long(test_data, 50)
expect(result.length).to eq(2)
```

**Bad (harder to test) code**:

```ruby
def process_data
  data = CSV.read('file.csv', headers: true)
  filtered = data.select { |row| row['Summary'].length > 100 }
  File.write('output.json', JSON.pretty_generate(filtered))
end

# Hard to test because it reads files, writes files, doesn't return anything
```

**Key insight**: Methods that take parameters and return values are easier to test than methods that depend on files and side effects.

---

## Phase 1: Ruby Basics (Current)

Understand how Ruby loads data, iterates, conditionals, and saves files.

### Core Concepts

- [ ] **File Loading**
  - [ ] CSV.read with headers
  - [ ] JSON.parse
  - [ ] File.read for plain text
  - [ ] Understand `require` vs `load`

- [ ] **Iteration Methods**
  - [ ] `.each` loops and blocks `{ |var| ... }`
  - [ ] `.map` (transform data)
  - [ ] `.select` (filter data)
  - [ ] `.take(n)` (limit results)
  - [ ] Method chaining (`.take().map().select()`)

- [ ] **Conditionals**
  - [ ] `if/elsif/else/end`
  - [ ] `||` (OR) and `&&` (AND)
  - [ ] Ternary operator `condition ? true_val : false_val`
  - [ ] Truthiness in Ruby (what's truthy/falsy?)

- [ ] **Data Structures**
  - [ ] Arrays `[1, 2, 3]` and indexing
  - [ ] Hashes `{key: value}` and symbol keys
  - [ ] String interpolation `"#{variable}"`
  - [ ] Accessing hash/array elements

- [ ] **File Output**
  - [ ] CSV.open for writing
  - [ ] JSON.pretty_generate
  - [ ] File.write

### Study Materials

- [ ] Read & understand `ruby_basics_tutorial.rb` completely
- [ ] Run the tutorial file (need data file first)
- [ ] Modify tutorial examples (change logic, add filters)
- [ ] Understand Bundler: `Gemfile`, `Gemfile.lock`, `bundle install`
- [ ] Understand RuboCop: runs `bundle exec rubocop`, fixes style issues
- [ ] Install pry for debugging: `gem install pry`

### Project 1: **Data Processor Script**

Load your CSV, filter by one column, transform one field, save to new CSV and JSON.

**Acceptance criteria (Ruby):**

- [ ] Loads CSV file without errors
- [ ] Filters data using `.select` with a condition you choose
- [ ] Transforms one column using `.map` (e.g., uppercase all summaries, truncate to 100 chars)
- [ ] Saves output to `output.csv` and `output.json`
- [ ] Code has no comments but is self-documenting
- [ ] **Passes RuboCop**: `bundle exec rubocop` shows no violations (or fixed with `-A`)
- [ ] **Has Gemfile**: Project uses bundler with rspec, pry, rubocop listed

**Acceptance criteria (Git/GitHub):**

- [ ] Create a new branch: `feature/project-1-data-processor`
- [ ] Make commits with clear messages describing what you did
- [ ] Commit message format: `Add CSV loading` or `Filter summaries by length`
- [ ] Final commit message includes context (what the script does)

**Acceptance criteria (lazyvim):**

- [ ] Edit file using only keybindings (no mouse)
- [ ] Split windows to view CSV and script side-by-side
- [ ] Use Telescope to create/navigate files
- [ ] Record one keybinding that saved you the most time

**Acceptance criteria (Testing):**

- [ ] Write tests for your filtering function (use RSpec)
- [ ] Write tests for your transformation function
- [ ] Test at least one edge case (empty data, single row, etc.)
- [ ] All tests pass: `rspec spec/data_processor_spec.rb`
- [ ] Tests verify the output files are created correctly
- [ ] Each test has a clear description of what it's checking

**Suggested steps:**

1. Decide what data you'll filter on (e.g., "only rows where Summary > 150 chars")
2. Decide what transformation (e.g., "capitalize all summaries")
3. Set up RSpec: `gem install rspec && rspec --init`
4. Write tests for your filter function (watch them fail first!)
5. Write the filter function to make tests pass
6. Write tests for your transform function
7. Write the transform function to make tests pass
8. Create a feature branch: `git checkout -b feature/project-1-data-processor`
9. Write your main script that uses the functions
10. Write integration tests (verify files are created)
11. Make commits with clear messages (test commit, function commit, main script commit)
12. Push to GitHub
13. What data will you filter on? (think like: "only rows where Summary > 150 chars")
14. What transformation? (think: "capitalize all summaries")
15. Create a branch for this work
16. Code it in Ruby
17. Run it and verify output files exist and have data
18. Commit with a clear message
19. Push to GitHub (optional, but good practice)

---

## Phase 2: Functions & Methods

Organize code into reusable pieces. Understand how to pass data in/out.

### Core Concepts

- [ ] **Method Definition**
  - [ ] `def method_name(params)`...`end`
  - [ ] Parameters and default values
  - [ ] Return values (implicit vs explicit)

- [ ] **Variable Scope**
  - [ ] Local variables (inside methods)
  - [ ] Instance variables `@var` (inside classes)
  - [ ] Global variables `$var` (avoid!)
  - [ ] Constants `CONST`

- [ ] **Common String Methods**
  - [ ] `.length`, `.upcase`, `.downcase`, `.capitalize`
  - [ ] `.split`, `.join`, `.strip`
  - [ ] `.start_with?`, `.include?`, `.empty?`

- [ ] **Common Array/Hash Methods**
  - [ ] `.length`, `.first`, `.last`
  - [ ] `.reverse`, `.sort`, `.uniq`
  - [ ] `.keys`, `.values`, `.has_key?`
  - [ ] `.push`, `.pop`, `.shift`, `.unshift` (mutate)

- [ ] **Blocks & Iterators**
  - [ ] Difference between `{ }` and `do...end`
  - [ ] `.each_with_index`
  - [ ] `.find` (first match)
  - [ ] `.any?`, `.all?`, `.none?`

### Study Materials

- [ ] Read Ruby style guide (methods section)
- [ ] Practice: convert tutorial code sections into methods

### Project 2: **Refactored Processor**

Take Project 1 and break it into functions.

**Acceptance criteria (Ruby):**

- [ ] Method to load CSV
- [ ] Method to filter data
- [ ] Method to transform data
- [ ] Method to save to CSV
- [ ] Method to save to JSON
- [ ] `main` method that calls them in order
- [ ] No repetition; each piece of logic in one place

**Acceptance criteria (Testing):**

- [ ] Each method has tests (test them individually)
- [ ] Tests pass when methods work correctly
- [ ] At least 70% code coverage
- [ ] Tests verify the `main` method works end-to-end

**Acceptance criteria (Git/GitHub):**

- [ ] New branch: `feature/project-2-refactored`
- [ ] Commit for each method group (e.g., "Add load_data and filter_data methods")
- [ ] Tests commit before methods commit
- [ ] Commit messages explain WHY you refactored (e.g., "Extract load_data to make it testable")

**Acceptance criteria (lazyvim):**

- [ ] Use splits to compare old code (Project 1) with new code
- [ ] Navigate between test file and implementation using Telescope
- [ ] No mouse (keybindings only)

**Suggested flow:**

```
def load_data(file_path)
def filter_data(data, condition)
def transform_data(data)
def save_csv(data, path)
def save_json(data, path)
def main
  data = load_data(...)
  filtered = filter_data(data, ...)
  transformed = transform_data(filtered)
  save_csv(transformed, ...)
  save_json(transformed, ...)
end
main
```

### Project 2b (Alternative): **Web Scraper with Classes**

Build a modular web scraper using classes and inheritance. Start with static HTML parsing (Nokogiri), design for future browser automation (Capybara).

**Why this project?** Combines functions, introduces classes, practices real-world architecture for extensible code.

**Acceptance criteria (Ruby):**

- [ ] Base `Scraper` class with common scraping logic
- [ ] `SinglePageScraper` subclass for simple HTML parsing
- [ ] `DeepScraper` subclass for multi-page/faceted scraping (design in place, may not implement all pages in Phase 2)
- [ ] `bin/scrape.rb` entry point that instantiates and runs scraper
- [ ] Uses Nokogiri for HTML parsing
- [ ] Saves results to JSON and CSV
- [ ] Error handling for network issues, missing elements
- [ ] Code is self-documenting, follows Ruby style
- [ ] **Passes RuboCop**: `bundle exec rubocop -A`

**Acceptance criteria (Testing):**

- [ ] Unit tests for Scraper class methods
- [ ] Tests for HTML parsing logic (use fixtures, not live websites)
- [ ] Edge case tests: missing elements, malformed HTML, empty results
- [ ] 70%+ code coverage
- [ ] All tests pass: `bundle exec rspec`

**Acceptance criteria (Git/GitHub):**

- [ ] Feature branch: `feature/web-scraper`
- [ ] Commits organized by feature (base class, subclass, parsing logic, error handling)
- [ ] Clear messages: `Add base Scraper class`, `Implement SinglePageScraper`, etc.

**Acceptance criteria (lazyvim):**

- [ ] Edit without mouse (keybindings only)
- [ ] Use Telescope for navigation
- [ ] Split between spec and implementation files

**Study materials before starting:**

- [ ] Classes tutorial file
- [ ] HTTP requests tutorial
- [ ] Nokogiri tutorial with examples
- [ ] Error handling patterns
- [ ] Practice scenarios: parse static HTML, handle missing data, multi-page patterns

**Suggested architecture:**

```ruby
# lib/scrapers/base_scraper.rb
class BaseScraper
  def initialize(url)
    @url = url
    @results = []
  end
  
  def scrape
    # Fetch, parse, validate, save
    fetch
    parse
    save
  end
  
  private
  
  def fetch
    # HTTP request logic
  end
  
  def parse
    # Override in subclasses
    raise NotImplementedError
  end
  
  def save
    # Save to JSON and CSV
  end
end

# lib/scrapers/single_page_scraper.rb
class SinglePageScraper < BaseScraper
  def parse
    # Nokogiri parsing for one page
  end
end

# lib/scrapers/deep_scraper.rb
class DeepScraper < BaseScraper
  def parse
    # Handle facets, multiple pages
    # Designed for future expansion
  end
end

# bin/scrape.rb
#!/usr/bin/env ruby
require_relative '../lib/scrapers/base_scraper'
require_relative '../lib/scrapers/single_page_scraper'

scraper = SinglePageScraper.new('https://example.com')
scraper.scrape
```

---

## Phase 3: Objects & Classes

Understand how to model real-world concepts as code.

### Core Concepts

- [ ] **Class Definition**
  - [ ] `class ClassName`...`end`
  - [ ] `initialize` method (constructor)
  - [ ] Instance variables `@var`
  - [ ] Attr accessors `attr_reader`, `attr_writer`, `attr_accessor`

- [ ] **Methods in Classes**
  - [ ] Instance methods (operate on one object)
  - [ ] Class methods `self.method_name`
  - [ ] Predicate methods (return true/false) `.empty?`, `.valid?`

- [ ] **Inheritance & Modules**
  - [ ] Extending classes with `<`
  - [ ] Mixins with `include`
  - [ ] `self` keyword

- [ ] **Error Handling**
  - [ ] `begin/rescue/ensure/end`
  - [ ] Raising exceptions `raise "message"`
  - [ ] Common errors (`StandardError`, `ArgumentError`)

### Study Materials

- [ ] Ruby Classes guide
- [ ] Compare to Python classes (familiar territory!)

### Project 3: **Summary Object**

Model a "Summary" as a class instead of a hash.

**Acceptance criteria (Ruby):**

- [ ] `Summary` class with initializer
- [ ] Instance variables: `text`, `length`, `created_at`
- [ ] Instance methods: `truncate(chars)`, `long?`, `to_csv_row`
- [ ] Load CSV into array of `Summary` objects
- [ ] Filter, transform, and save using the class

**Acceptance criteria (Testing):**

- [ ] Unit tests for Summary class (test each method)
- [ ] Test edge cases: empty text, nil values, negative chars
- [ ] Test that CSV loading creates Summary objects correctly
- [ ] Test filtering logic on Summary objects
- [ ] 80%+ code coverage
- [ ] All tests pass

**Acceptance criteria (Git/GitHub):**

- [ ] New branch: `feature/project-3-summary-class`
- [ ] Commit 1: Create Summary class with tests
- [ ] Commit 2: Update loader to create Summary objects
- [ ] Commit 3: Update filter/transform to work with Summary objects
- [ ] Each commit should compile and tests should pass

**Acceptance criteria (lazyvim):**

- [ ] Navigate between spec and implementation files using Telescope
- [ ] Run tests without leaving editor (`:!rspec` or custom keybinding)
- [ ] Split windows to view class definition and tests simultaneously

**Example:**

```ruby
class Summary
  attr_reader :text, :created_at
  
  def initialize(text, created_at = Time.now)
    @text = text
    @created_at = created_at
  end
  
  def length
    @text.length
  end
  
  def long?
    length > 100
  end
  
  def truncate(chars)
    @text[0...chars]
  end
end
```

---

## Phase 4: Rails Concepts (Preview)

Understand how Rails organizes this into the MVC pattern.

### Core Concepts

- [ ] **What is Rails?**
  - [ ] Framework that organizes Ruby code
  - [ ] MVC pattern: Model, View, Controller
  - [ ] Convention over Configuration

- [ ] **Directory Structure**
  - [ ] `app/models` — Your classes (like Summary)
  - [ ] `app/controllers` — Logic that handles requests
  - [ ] `app/views` — HTML templates that display data
  - [ ] `config/` — Settings
  - [ ] `db/` — Database schemas and migrations

- [ ] **Databases (intro)**
  - [ ] SQL vs ORM (ActiveRecord)
  - [ ] Models map to database tables
  - [ ] Migrations create/modify tables

- [ ] **HTTP Requests (conceptual)**
  - [ ] GET/POST/PUT/DELETE
  - [ ] Routes map URLs to controller actions
  - [ ] Controllers receive data, call models, return views

### Study Materials

- [ ] Rails Guides: Getting Started
- [ ] Compare Project 3's class structure to a Rails Model

### Project 4: **Mini Rails Structure** (no actual Rails yet)

Organize Project 3 code like Rails does.

**File structure:**

```
app/
  models/
    summary.rb        # Summary class
controllers/
  summaries_controller.rb  # Logic: load, filter, transform
bin/
  process.rb         # Entry point (like main)
```

**Acceptance criteria:**

- [ ] `app/models/summary.rb` contains Summary class
- [ ] `app/controllers/summaries_controller.rb` has methods like `filter_by_length`, `process`
- [ ] `bin/process.rb` calls controller methods
- [ ] No duplicate code; everything in one place

---

## Phase 5: Real Rails Project

Apply all learning to an actual Rails application.

### Core Concepts

- [ ] **Generate Rails App**
  - [ ] `rails new project_name`
  - [ ] Project structure
  - [ ] Gemfile (dependencies)

- [ ] **Scaffolding & Generators**
  - [ ] Create models with `rails generate model`
  - [ ] Create controllers with `rails generate controller`
  - [ ] Migrations and databases

- [ ] **Active Record (ORM)**
  - [ ] Define models
  - [ ] Queries: `.all`, `.where`, `.find`, `.map`
  - [ ] Associations (has_many, belongs_to)

- [ ] **Routing & Controllers**
  - [ ] RESTful routes
  - [ ] Controller actions (index, show, create, update, destroy)
  - [ ] Rendering JSON/views

- [ ] **Testing**
  - [ ] RSpec basics
  - [ ] Test models and controllers

### Study Materials

- [ ] Official Rails Guides: [Getting Started](https://guides.rubyonrails.org/getting_started.html)
- [ ] Create a tiny Rails app with one model

### Project 5: **Rails Summaries App**

Build a Rails API/web app that loads, stores, filters summaries.

**Acceptance criteria:**

- [ ] Rails app generated with `rails new`
- [ ] `Summary` model with database table
- [ ] `SummariesController` with index (list all) and filter (by length)
- [ ] Load CSV data into database (Rails seed file)
- [ ] Test that you can query summaries
- [ ] Return JSON from API endpoints

---

## Continuous Learning Habits

- [ ] Read one Ruby file from real projects each week (GitHub, open source)
- [ ] Write a tiny script every few days to practice
- [ ] Keep a "Ruby patterns" document (how to do X in Ruby)
- [ ] Ask questions: "Why did they write it this way?"

---

## Success Metrics

### You'll know Phase 1 is complete when

- [ ] You can explain what each section of the tutorial does
- [ ] You've modified the tutorial and re-run it
- [ ] You've written Project 1 from scratch (with minimal hints)
- [ ] You understand `.each`, `.map`, `.select` and when to use each
- [ ] You're comfortable with Ruby syntax (indentation, `end` keyword, blocks)
- [ ] **Your tests pass**: RSpec runs all tests for Project 1 successfully

### You'll know Phase 2 is complete when

- [ ] You can refactor code into reusable methods
- [ ] You understand variable scope (local, instance, global)
- [ ] You've written Project 2 with clear methods and good tests
- [ ] Methods take parameters and return values (not side effects)
- [ ] **Your tests pass**: Project 2 has 70%+ coverage, all green

### You'll know Phase 3 is complete when

- [ ] You understand how to model real-world concepts as classes
- [ ] You're comfortable with `initialize`, instance variables, methods
- [ ] You've built Project 3 (Summary class) with comprehensive tests
- [ ] You can read and understand class-based Ruby code
- [ ] **Your tests pass**: Project 3 has 80%+ coverage, all green

### You'll know the full curriculum is complete when

- [ ] You've built all 5 projects end-to-end
- [ ] You read Rails code in a team project without excessive confusion
- [ ] You can estimate effort on Ruby/Rails tickets
- [ ] You write tests alongside code automatically (not as afterthought)
- [ ] Your git commits tell a clear story of what you built and why
- [ ] You navigate lazyvim efficiently (no mouse, natural keybindings)
- [ ] You feel confident asking for help (because you know what you don't know)

---

## How to Use This Plan

1. **Check off items** as you understand them (don't wait until perfect mastery)
2. **Do the projects** in order; they build on each other
3. **Get stuck?** That's the learning. Try for 20 min, then ask
4. **Revisit**: Phases 1-3 might take 2-3 weeks total with consistent practice
5. **Milestone**: After Project 3, you'll feel like a real programmer. After Project 5, you'll be ready for actual Rails work

---

## Memory & Context for Future Sessions

**Stored in**: `/Users/paulwilliams/.claude/projects/-Users-paulwilliams-Documents-GitHub-learning-ruby-claude-teaching/memory/`

Files:

- `MEMORY.md` — Index of all stored context
- `user_background.md` — Your role, goals, experience
- `feedback_teaching.md` — How you like to learn
- `user_tools.md` — mise, lazyvim preferences
- `project_goal.md` — Current learning targets

**For future Claude sessions**: Ask the new Claude to "Check my memory files" or "Refer to my learning context" and they'll have everything.

---

## Next Steps Right Now

1. Open `ruby_basics_tutorial.rb` in lazyvim
2. Run the file (if you have the data file)
3. Modify one section and re-run
4. Pick a question from the tutorial to experiment with
5. Start **Project 1** when you feel ready

Good luck! 🎯
