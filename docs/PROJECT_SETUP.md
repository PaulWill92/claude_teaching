# New Ruby Project Setup Checklist

A quick reference guide for starting any new Ruby learning project. Use this before beginning each project.

---

## Step 1: Create Project Directory

```bash
mkdir project_name
cd project_name
```

## Step 2: Initialize Git

```bash
git init
```

This enables ruby-lsp to detect the project root.

## Step 3: Create .ruby-version (mise)

Create `.ruby-version` file:

```bash
echo "3.2.10" > .ruby-version
```

Or check your current version:

```bash
ruby -v
# Copy the version number into .ruby-version
```

Verify mise loads it:

```bash
mise install
```

## Step 4: Create Gemfile

```bash
bundle init
```

This creates a basic Gemfile. Then add your dependencies:

```ruby
# Gemfile
source "https://rubygems.org"

gem "ruby-lsp", require: false
gem "rspec"
gem "pry"
gem "rubocop", require: false
```

## Step 5: Install Dependencies

```bash
bundle install
```

This creates `Gemfile.lock` (commit this to git).

## Step 6: Create Project Structure

Create folders for your project:

```bash
mkdir -p app spec bin
```

**Folder purposes**:
- `app/` — Main application code (models, helpers, utilities)
- `spec/` — RSpec test files (mirrors app/ structure)
- `bin/` — Executable scripts (entry points)

Example structure:

```
project_name/
├── .ruby-version       ← mise version config
├── Gemfile            ← dependencies
├── Gemfile.lock       ← locked versions (commit this)
├── .gitignore         ← (optional, for excluding files)
├── app/
│   ├── models/
│   ├── helpers/
│   └── utils/
├── spec/
│   ├── models/
│   ├── helpers/
│   └── utils/
├── bin/
│   └── process.rb     ← entry point script
└── README.md          ← (optional, project description)
```

## Step 7: Create .gitignore (Optional)

```bash
cat > .gitignore << 'EOF'
.DS_Store
.idea/
*.swp
*.swo
*~
.ruby-version.local
coverage/
EOF
```

## Step 8: Make Initial Commit

```bash
git add .ruby-version Gemfile Gemfile.lock .gitignore
git commit -m "Initialize Ruby project with dependencies"
```

## Step 9: Open in lazyvim

```bash
nvim .
```

Verify ruby-lsp loaded (check `:LspInfo`).

---

## Quick Reference Commands

| Task | Command |
|------|---------|
| Install/update gems | `bundle install` |
| Run tests | `bundle exec rspec` |
| Run linter | `bundle exec rubocop` |
| Auto-fix style | `bundle exec rubocop -A` |
| Interactive console | `bundle exec pry` |
| Check LSP status | `:LspInfo` (in nvim) |

---

## Checklist for New Project

Use this checklist when starting a project:

- [ ] `mkdir project_name && cd project_name`
- [ ] `git init`
- [ ] Create `.ruby-version` (copy your Ruby version)
- [ ] `bundle init`
- [ ] Add gems to Gemfile (ruby-lsp, rspec, pry, rubocop)
- [ ] `bundle install`
- [ ] `mkdir -p app spec bin`
- [ ] Create `.gitignore` (optional)
- [ ] `git add` and `git commit` initial files
- [ ] `nvim .` and verify `:LspInfo`
- [ ] Ready to code!

---

## Project 1 Specific

For Project 1 (Data Processor), your structure will look like:

```
project_1/
├── .ruby-version
├── Gemfile
├── Gemfile.lock
├── .gitignore
├── project_1.rb         ← main script
├── spec/
│   └── project_1_spec.rb   ← tests
├── data/
│   └── all_summaries_26-03-2026.csv
└── output/              ← (created by script)
    ├── output.csv
    └── output.json
```

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| ruby-lsp not loading | Verify `.ruby-version` or `.git` exists in project root |
| `bundle: command not found` | Run `gem install bundler` |
| Gems won't install | Check Ruby version matches `.ruby-version` |
| `Gemfile.lock` conflicts | Run `bundle install` to update |

---

**Use this as a template every time you start a new project.** Consistency = faster setup = more time coding! 🚀
