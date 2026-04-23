# Ruby Learning Journey

Welcome! This is your learning repository for transitioning from Python/data science to Ruby and Rails.

---

## 🚀 Quick Start

**First time here?** Start with this order:

1. **[HOW_TO_LEARN.md](./HOW_TO_LEARN.md)** ← **Start here** — Your learning journey guide
2. **[STUDY_PLAN.md](./STUDY_PLAN.md)** — The curriculum (phases, projects, criteria)
3. **[CLAUDE_CONTEXT.md](./CLAUDE_CONTEXT.md)** — How we work together (teaching style)
4. **Start Phase 1 tutorials** — Work through ruby_basics_tutorial.rb
5. **Tell Claude:** "Ready to start Project 1"

---

## 📁 Folder Organization

### Root Level (Core Reference)
- **CLAUDE_CONTEXT.md** — Master teaching context + your profile
- **STUDY_PLAN.md** — Learning path with phases, projects, acceptance criteria
- **ruby_basics_tutorial.rb** — Starting tutorial (file I/O, iteration, conditionals)
- **Gemfile** / **Gemfile.lock** — Project dependencies
- **.ruby-version** — Ruby version (managed by mise)

### `/docs` — Guides & How-Tos
- **LAZYVIM_WORKFLOW.md** — Editor keybindings, navigation, workflows
- **PROJECT_SETUP.md** — Checklist for starting new projects
- *(Add more guides here as we go)*

### `/projects` — Your Project Work
Where you'll create each project:
- `project_1/` — Data processor script
- `project_2/` — Refactored with functions
- `project_3/` — Summary class
- *(More as you progress)*

### `/data` — Data Files
- **all_summaries_26-03-2026.csv** — CSV data for learning

### `/reference` — Quick Lookup
*(Build as needed)*
- Ruby cheatsheet
- Git commands reference
- RuboCop rules reference

### `/tutorials` — Hands-On Learning
Self-contained tutorial files for each learning phase:
- **tutorials/phase_3_classes_and_web_scraping/** — Classes, HTTP, HTML parsing, error handling
  - `classes_tutorial.rb` — OOP fundamentals and inheritance
  - `http_requests_tutorial.rb` — Fetching data from the web
  - `nokogiri_tutorial.rb` — Parsing HTML with Nokogiri
  - `error_handling_tutorial.rb` — Exceptions and recovery strategies
  - `practice_scenarios.rb` — 10 progressive challenges building toward Project 2b
  - **README.md** — How to use tutorials with IRB/pry and split windows

**How to use:** Open tutorial in right split, IRB in left split, code along. See `tutorials/README.md` for detailed workflow.

---

## 🧠 Your Learning Context

Your background and preferences are stored in **memory files** (not in this repo):

```
~/.claude/projects/.../memory/
├── MEMORY.md (index)
├── user_background.md
├── feedback_teaching.md
├── user_tools.md
├── project_goal.md
├── parallel_learning_goals.md
├── testing_discipline.md
├── debugging_with_pry.md
└── company_standards.md
```

**For future Claude sessions**: Just say *"Check my memory files"* and I'll have full context.

---

## 📖 Learning Phases

### Phase 1: Ruby Basics ← **YOU ARE HERE**
File I/O, iteration, conditionals, data structures
- **Project 1**: Data processor script

### Phase 2: Functions & Methods
Organize code into reusable pieces
- **Project 2**: Refactored processor

### Phase 3: Objects & Classes
Model real-world concepts
- **Project 3**: Summary class

### Phase 4: Rails Concepts
Understand MVC architecture (preview)
- **Project 4**: Rails-like structure

### Phase 5: Real Rails
Build a Rails application
- **Project 5**: Rails API/app

---

## 🛠 Essential Commands

### Starting a New Project
```bash
# Follow the checklist in docs/PROJECT_SETUP.md
```

### Running Code
```bash
bundle exec ruby project_1.rb
bundle exec rspec spec/project_1_spec.rb
bundle exec rubocop
bundle exec pry
```

### lazyvim Navigation
```
leader + ff     Find file
leader + fg     Find text
ctrl + v        Vertical split
leader + sw     Go to definition
gd              Goto definition
K               Hover docs
```

See [docs/LAZYVIM_WORKFLOW.md](./docs/LAZYVIM_WORKFLOW.md) for full reference.

---

## 📋 Your Setup

✅ **Editor**: lazyvim (default keybindings)  
✅ **Version Manager**: mise (Ruby 3.2.10)  
✅ **Dependency Manager**: Bundler  
✅ **Style Enforcement**: RuboCop (company standard)  
✅ **Testing**: RSpec + pry  
✅ **LSP**: ruby-lsp + rubocop  

---

## 🎯 How to Use This Repo

### Daily Workflow
1. **Check STUDY_PLAN.md** — What's next?
2. **Reference docs/** — Need a guide? (PROJECT_SETUP, LAZYVIM_WORKFLOW)
3. **Work in projects/** — Create/run your project
4. **Commit regularly** — Good git messages (see docs/PROJECT_SETUP.md)

### During Coding Sessions
- **Stuck?** → Reference relevant guide in `docs/`
- **Starting new project?** → Follow `docs/PROJECT_SETUP.md` checklist
- **Editor question?** → Check `docs/LAZYVIM_WORKFLOW.md`
- **Testing question?** → See STUDY_PLAN.md phase details

### Finding Things with Telescope (lazyvim)
```
leader + ff     Find any file/doc
leader + fg     Search inside docs
leader + ss     Search symbols in current file
```

Type "workflow" → jumps to LAZYVIM_WORKFLOW.md  
Type "setup" → jumps to PROJECT_SETUP.md  
Type "study" → jumps to STUDY_PLAN.md  

---

## 📝 Notes

- **CLAUDE_CONTEXT.md** describes how I teach and who you are
- **STUDY_PLAN.md** is your checklist—mark off items as you complete them
- **docs/** guides are your references—use them liberally
- **projects/** is where the real work happens
- **Memory files** persist across sessions—future Claude instances will know everything

---

## 🚦 What's Next?

**When you're ready to start Project 1:**

1. Open **[docs/PROJECT_SETUP.md](./docs/PROJECT_SETUP.md)**
2. Follow the checklist
3. Message me and we'll begin!

Good luck! You've got this. 🎯

---

**Last updated**: 2026-04-22  
**Learning phase**: Ruby Basics (Phase 1)  
**Next milestone**: Complete Project 1
