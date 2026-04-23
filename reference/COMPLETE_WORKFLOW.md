# Complete Project Workflow Reference

End-to-end workflow for starting and completing a Ruby project.

## Phase 1: Project Setup

### 1. Create Project Directory

```bash
mkdir project_name
cd project_name
git init
```

### 2. Create `.ruby-version`

```bash
echo "3.2.10" > .ruby-version
mise install
```

### 3. Initialize Bundler

```bash
bundle init
```

Edit `Gemfile`:
```ruby
source "https://rubygems.org"

gem "ruby-lsp", require: false
gem "rspec"
gem "pry"
gem "rubocop", require: false
```

Then:
```bash
bundle install
```

### 4. Create Folder Structure

```bash
mkdir -p app spec bin data
```

### 5. Create `.gitignore`

```bash
cat > .gitignore << 'EOF'
.DS_Store
*.swp
*.swo
*~
.ruby-version.local
coverage/
.ruby-lsp/
EOF
```

### 6. Initial Git Commit

```bash
git add .ruby-version Gemfile Gemfile.lock .gitignore
git commit -m "Initialize Ruby project with dependencies"
```

### 7. Open in lazyvim

```bash
nvim .
```

Verify `:LspInfo` shows `ruby_lsp` loaded.

---

## Phase 2: Development

### 1. Create Feature Branch

```bash
git checkout -b feature/feature-name
```

### 2. Write Tests First

Create `spec/feature_spec.rb`:

```ruby
require 'rspec'
require_relative '../app/feature'

describe 'feature' do
  it 'does something' do
    result = some_function()
    expect(result).to eq(expected)
  end
end
```

Run and watch it fail:
```bash
bundle exec rspec
```

### 3. Write Code to Pass Tests

Create `app/feature.rb`:

```ruby
def some_function
  # implementation
end
```

Run tests again:
```bash
bundle exec rspec
```

### 4. Check Style with RuboCop

```bash
bundle exec rubocop
bundle exec rubocop -A  # Auto-fix
```

### 5. Commit When Tests Pass

```bash
git add app/feature.rb spec/feature_spec.rb
git commit -m "Add feature with tests"
```

Good commit messages:
- `"Add CSV loading"`
- `"Filter data by length"`
- `"Create Summary class"`
- `"Fix edge case in filter"`

### 6. Repeat for Each Feature

Each feature gets:
- Tests first
- Implementation
- RuboCop fix
- Commit

---

## Phase 3: Testing & Debugging

### Run All Tests

```bash
bundle exec rspec
bundle exec rspec --format documentation  # Prettier
```

### Debug a Test

Add `binding.pry` in your code:

```ruby
def process_data(data)
  binding.pry  # Pauses here
  data.select { |x| x > 5 }
end
```

At the pry prompt:
```
data            # Inspect variable
data.length     # Check length
exit            # Continue
```

### Check Coverage

View test results and coverage info:

```bash
bundle exec rspec
```

Goal: 80%+ coverage.

---

## Phase 4: Final Polish

### Clean Up Code

```bash
bundle exec rubocop -A  # Auto-fix all style issues
```

### Run Full Test Suite

```bash
bundle exec rspec --format documentation
```

All green? ✅

### Final Commit

```bash
git add .
git commit -m "Final polish: style and cleanup"
```

### Check Git Log

```bash
git log --oneline
```

Your commits should tell a story:
```
abc1234 Final polish: style and cleanup
def5678 Add edge case handling
ghi9012 Create data processor
jkl3456 Initialize project
```

---

## Phase 5: Submission/Completion

### Create a README (Optional)

```bash
cat > README.md << 'EOF'
# Project Name

Brief description of what this does.

## Running

```bash
bundle exec ruby bin/process.rb
```

## Testing

```bash
bundle exec rspec
```

## Requirements

- Ruby 3.2.10
- See Gemfile for dependencies
EOF
```

### Final Status

```bash
git status                    # Should be clean
bundle exec rspec             # All green
bundle exec rubocop           # No violations
git log --oneline             # Clear history
```

---

## Quick Commands Reference

| Task | Command |
|------|---------|
| Create branch | `git checkout -b feature/name` |
| Run tests | `bundle exec rspec` |
| Fix style | `bundle exec rubocop -A` |
| Debug test | Add `binding.pry`, run tests |
| View commits | `git log --oneline` |
| Check status | `git status` |
| Add files | `git add file.rb` |
| Commit | `git commit -m "Message"` |

---

## Workflow Checklist

Use this for each project:

**Setup Phase:**
- [ ] Created project directory and git init
- [ ] Created `.ruby-version`
- [ ] Ran `bundle init` and `bundle install`
- [ ] Created folder structure (app/, spec/, bin/, data/)
- [ ] Created `.gitignore`
- [ ] Initial git commit
- [ ] Verified nvim LSP works (`:LspInfo`)

**Development Phase:**
- [ ] Created feature branch
- [ ] Wrote tests for each function
- [ ] Wrote code to pass tests
- [ ] Ran RuboCop and fixed style
- [ ] Made atomic commits with good messages
- [ ] All tests still passing

**Final Phase:**
- [ ] RuboCop clean (no violations)
- [ ] All tests passing (100% of specs you wrote)
- [ ] Git log tells a story
- [ ] Ready to submit/move on

---

## Common Patterns

**Per function:**
1. Write test that fails
2. Write function that makes test pass
3. Run RuboCop and fix style
4. Commit

**Per feature:**
1. Create feature branch
2. Repeat "per function" above for all functions in feature
3. Run full test suite
4. Merge back to main

---

**Remember**: Structure, tests, style, commits. In that order, every time.
