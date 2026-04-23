# How to Approach This Learning Journey

Welcome! This guide explains how to get the most out of your Ruby learning.

---

## Before You Start: Read This Order

1. **This file** (HOW_TO_LEARN.md) ← You are here
2. **[STUDY_PLAN.md](./STUDY_PLAN.md)** — Understand the phases and projects
3. **[CLAUDE_CONTEXT.md](./CLAUDE_CONTEXT.md)** — Understand how we work together
4. **[README.md](./README.md)** — Folder organization and quick reference

---

## The Learning Philosophy

You learn best by:
- **Thinking first, then coding** — I'll ask you to think before giving answers
- **Doing projects, not just reading** — Theory + Practice together
- **Building habits** — Testing, Git commits, clean code (from day one)
- **One thing at a time** — Focus on current phase, not future phases

This is intentional. It's how you'd learn on the job.

---

## How Each Phase Works

### Phase Structure

Every phase has:
1. **Tutorials** — Learn concepts (in `/tutorials/`)
2. **Study checklist** — Track understanding in STUDY_PLAN.md
3. **Project** — Apply what you learned
4. **Acceptance criteria** — Know when you're done

### Your Phase Workflow

```
1. Review Phase in STUDY_PLAN.md
   ↓
2. Work through tutorials (read + code in IRB)
   ↓
3. Tell Claude: "Ready to start Project X"
   ↓
4. Claude helps you set up and guide through project
   ↓
5. Complete acceptance criteria (Ruby, Testing, Git, lazyvim)
   ↓
6. Tell Claude: "Completed Project X"
   ↓
7. Move to next phase
```

---

## Phase 1: Ruby Basics (Starting Now)

### Step 1: Read STUDY_PLAN.md
Open `STUDY_PLAN.md` and review **Phase 1** section.

- [ ] Read Phase 1 core concepts checklist
- [ ] Read Phase 1 study materials
- [ ] Read Project 1 acceptance criteria
- [ ] Understand success metrics

### Step 2: Study the Concepts
You don't have tutorials for Phase 1 (you have `ruby_basics_tutorial.rb` in `/docs`).

- [ ] Read `docs/ruby_basics_tutorial.rb` completely
- [ ] Run the tutorial: `ruby docs/ruby_basics_tutorial.rb`
- [ ] Modify examples (change logic, test edge cases)
- [ ] Understand all concepts before moving to project

### Step 3: Set Up Your First Project
When ready:
- [ ] Tell Claude: **"Ready to start Project 1: Data Processor"**
- Claude will help you:
  - Create project folder
  - Set up git, Gemfile, RSpec
  - Create first tests
  - Guide you through building the script

### Step 4: Complete Project 1
Follow acceptance criteria in STUDY_PLAN.md:

**Ruby:**
- [ ] Loads CSV file
- [ ] Filters data
- [ ] Transforms data
- [ ] Saves to CSV and JSON
- [ ] Passes RuboCop

**Testing:**
- [ ] Write tests for filtering function
- [ ] Write tests for transformation function
- [ ] Test edge cases
- [ ] All tests pass

**Git/GitHub:**
- [ ] Create feature branch
- [ ] Make atomic commits with clear messages
- [ ] Push to GitHub

**lazyvim:**
- [ ] Edit using only keybindings (no mouse)
- [ ] Use splits and Telescope
- [ ] Note one keybinding that saved time

### Step 5: Complete Phase 1
When done:

- [ ] All acceptance criteria met
- [ ] Tests passing
- [ ] Git history is clean
- [ ] Tell Claude: **"Completed Project 1"**

Then move to Phase 2 →

---

## Phase 2 & Beyond: Same Pattern

### Phase 2: Functions & Methods
- [ ] Review STUDY_PLAN.md Phase 2
- [ ] Work through tutorials (if available)
- [ ] Tell Claude: "Ready for Project 2" (Refactored Processor)
- [ ] Complete Project 2
- [ ] Tell Claude: "Completed Project 2"

### Phase 2b: Web Scraper (Alternative/After Phase 2)
- [ ] Review STUDY_PLAN.md Project 2b
- [ ] Work through Phase 3 tutorials:
  - [ ] `tutorials/phase_3_classes_and_web_scraping/classes_tutorial.rb`
  - [ ] `tutorials/phase_3_classes_and_web_scraping/http_requests_tutorial.rb`
  - [ ] `tutorials/phase_3_classes_and_web_scraping/nokogiri_tutorial.rb`
  - [ ] `tutorials/phase_3_classes_and_web_scraping/error_handling_tutorial.rb`
  - [ ] `tutorials/phase_3_classes_and_web_scraping/practice_scenarios.rb`
- [ ] Tell Claude: "Ready to start Project 2b: Web Scraper"
- [ ] Complete Project 2b
- [ ] Tell Claude: "Completed Project 2b"

### Phase 3: Classes & Objects
- [ ] Review STUDY_PLAN.md Phase 3
- [ ] Work through tutorials (if new ones created)
- [ ] Tell Claude: "Ready for Project 3"
- [ ] Complete Project 3
- [ ] Tell Claude: "Completed Project 3"

### Phase 4: Rails Concepts
- [ ] Review STUDY_PLAN.md Phase 4
- [ ] Work through Service Objects tutorials:
  - [ ] `tutorials/phase_4_rails_concepts/service_objects_intro.rb`
  - [ ] `tutorials/phase_4_rails_concepts/service_objects_intermediate.rb`
  - [ ] `tutorials/phase_4_rails_concepts/service_objects_advanced.rb`
  - [ ] `tutorials/phase_4_rails_concepts/service_objects_practice.rb`
- [ ] Tell Claude: "Ready for Project 4"
- [ ] Complete Project 4
- [ ] Tell Claude: "Completed Project 4"

### Phase 5: Real Rails
- [ ] Review STUDY_PLAN.md Phase 5
- [ ] Build a real Rails app
- [ ] Tell Claude: "Completed Project 5"

---

## How to Use Tutorials

When working through tutorials (Phase 2b, 3, 4, etc.):

### Setup (One Time)
```bash
cd ~/Documents/GitHub/learning/ruby/claude_teaching/tutorials/phase_X/
nvim .
```

### Workflow
1. Open tutorial in right split: `leader + ff` → select file
2. Open IRB in left split: `ctrl + v`, `:terminal`, `irb`
3. **Read** → **Copy** → **Paste into IRB** → **Test** → **Repeat**

See `tutorials/README.md` for detailed keybindings and workflow.

---

## When to Ask for Help

### Ask Claude When:
- ✓ You're stuck (tried for 20+ min)
- ✓ You don't understand a concept
- ✓ You want feedback on your code
- ✓ You want to know if you're on track
- ✓ You hit an error you can't figure out
- ✓ You're ready to start/finish a phase

### Try On Your Own First When:
- A tutorial example isn't working → debug it
- A test fails → read the error message
- You're unsure about a concept → re-read that section
- You think you understand → test yourself

**20-minute rule:** If you're stuck for 20+ minutes, ask. That's the learning sweet spot (struggle enough to learn, not so much you get frustrated).

---

## Communication with Claude

### Telling Claude You're Ready

When you've finished prerequisites for a phase, tell Claude:

```
"Ready to start Project 1: Data Processor"
```

I'll:
- Help you set up the project structure
- Guide you through the first steps
- Answer questions as you go
- Check your work against acceptance criteria

### Telling Claude You're Done

When you've completed a project:

```
"Completed Project 1. Ready for next phase"
```

I'll:
- Review your work briefly
- Confirm acceptance criteria are met
- Give you the next phase overview
- Prepare you for what comes next

### Asking for Help Mid-Project

During a project, if you're stuck:

```
"I'm stuck on X. I've tried Y and Z. What should I do?"
```

I'll help you debug, explain, or point you in the right direction.

---

## Tracking Your Progress

### Use STUDY_PLAN.md Checkboxes

In `STUDY_PLAN.md`, each phase has checkboxes:

```markdown
## Phase 1: Ruby Basics

### Core Concepts
- [ ] File Loading
  - [ ] CSV.read with headers
  - [ ] JSON.parse
  - [ ] File.read for plain text
```

As you learn each concept, check it off. Helps you:
- See progress
- Know what to review
- Understand what's left

### Git History as Progress

Each commit is a milestone:
```
abc1234 Add CSV loading
def5678 Add filtering by length
ghi9012 Add transformation logic
jkl3456 Add file output
mno7890 Add tests
```

Looking back at `git log` shows your learning journey.

---

## Important Reminders

### 1. Don't Skip Phases
The curriculum is designed to build on itself:
- Phase 1 → Phase 2 → Phase 2b/3 → Phase 4 → Phase 5

Each phase assumes you completed the previous one.

### 2. Do Projects, Not Just Tutorials
Tutorials teach concepts. Projects teach *how to apply them*.

**Both matter.** Read the tutorial, then build the project.

### 3. Tests Are Your Friend
Write tests as you code, not after.

This becomes automatic—a professional habit.

### 4. One Thing at a Time
Focus on current phase. Don't worry about Rails until Phase 4.

You'll learn faster by going deep on one thing than shallow on many things.

### 5. Commit Often
Small, clear commits tell a story:

```
git commit -m "Add CSV loading"
git commit -m "Add filtering logic"
git commit -m "Add file output"
```

Not:

```
git commit -m "Finished project"
```

### 6. Use Memory for Context
Claude saves your preferences and context in memory files.

Future Claudes will know:
- Your background (Python, data science)
- Teaching preferences (guided discovery)
- Current progress (which phase)
- Feedback you've given

So you don't need to re-explain everything each session.

---

## Your First Step

1. **Read STUDY_PLAN.md** — Understand Phase 1
2. **Read ruby_basics_tutorial.rb** — Learn the concepts
3. **Tell Claude:** "Ready to start Project 1: Data Processor"

Then we'll dive in together.

---

## Questions?

If anything in this guide is unclear:
- Ask Claude
- Re-read STUDY_PLAN.md
- Check specific tutorials for details

You've got this. Let's go. 🚀
