# Project Structure Reference

Standard Ruby project layout you'll use for all projects.

## Basic Structure

```
project_name/
├── .ruby-version      ← Ruby version (mise)
├── Gemfile            ← Dependencies
├── Gemfile.lock       ← Locked versions
├── .gitignore         ← Git exclusions
├── README.md          ← Project description
│
├── app/               ← Application code
│   ├── models/        ← Classes/data structures
│   ├── helpers/       ← Utility functions
│   └── utils/         ← General utilities
│
├── spec/              ← Tests (mirrors app/)
│   ├── models/
│   ├── helpers/
│   └── utils/
│
├── bin/               ← Executable scripts
│   └── run.rb         ← Entry point
│
└── data/              ← Data files
    └── input.csv
```

## File Naming Conventions

```
app/models/summary.rb        ← Class: Summary
app/helpers/math_helper.rb   ← Functions: related to math
spec/models/summary_spec.rb  ← Tests for summary.rb

Functions: snake_case
Classes: PascalCase
Files: snake_case
```

## Mirroring Structure

**Rule**: `spec/` mirrors `app/` exactly.

```
app/models/user.rb          → spec/models/user_spec.rb
app/helpers/filter.rb       → spec/helpers/filter_spec.rb
app/utils/math.rb           → spec/utils/math_spec.rb
```

This makes finding tests easy.

## For Project 1 (Data Processor)

```
project_1/
├── .ruby-version
├── Gemfile
├── Gemfile.lock
├── .gitignore
│
├── project_1.rb           ← Main script
├── spec/
│   └── project_1_spec.rb  ← Tests
│
└── data/
    └── all_summaries_26-03-2026.csv
```

**Also creates** (when script runs):
```
output/
├── output.csv
└── output.json
```

## For Project 2 (Refactored)

```
project_2/
├── Gemfile
├── Gemfile.lock
│
├── app/
│   ├── data_processor.rb    ← Main logic
│   └── loaders/
│       └── csv_loader.rb
│
├── spec/
│   ├── data_processor_spec.rb
│   └── loaders/
│       └── csv_loader_spec.rb
│
├── bin/
│   └── run.rb              ← Entry point
│
└── data/
    └── input.csv
```

Run with: `bundle exec ruby bin/run.rb`

## For Project 3 (Classes)

```
project_3/
├── app/
│   ├── models/
│   │   └── summary.rb      ← Class: Summary
│   └── processors/
│       └── data_processor.rb
│
├── spec/
│   ├── models/
│   │   └── summary_spec.rb
│   └── processors/
│       └── data_processor_spec.rb
│
├── bin/
│   └── process.rb          ← Entry point
│
└── data/
    └── input.csv
```

## Common Mistakes

❌ **Putting everything in one file**:
```
project.rb     ← 500 lines of mixed code
```

✅ **Separating concerns**:
```
app/models/summary.rb      ← Data structure
app/helpers/processor.rb   ← Logic
spec/models/summary_spec.rb ← Tests
```

❌ **Ignoring the spec mirror**:
```
app/helpers/math.rb
spec/test_math.rb          ← Wrong naming/location
```

✅ **Following the pattern**:
```
app/helpers/math.rb
spec/helpers/math_spec.rb  ← Mirrors structure
```

## Git Files (.gitignore)

```
.DS_Store
*.swp
*.swo
*~
.ruby-version.local
coverage/
.ruby-lsp/
```

## Project Root Checklist

When starting a project, create these files:

- [ ] `.ruby-version` — Your Ruby version (e.g., 3.2.10)
- [ ] `Gemfile` — Dependencies (ruby-lsp, rspec, pry, rubocop)
- [ ] `Gemfile.lock` — Run `bundle install` to create
- [ ] `.gitignore` — Copy from template above
- [ ] `bin/run.rb` or script — Entry point (or at root for simple projects)
- [ ] Folder structure — `app/`, `spec/`, `data/` as needed

---

**Remember**: Structure makes finding code easy. Someone reading your code should know exactly where to look.
