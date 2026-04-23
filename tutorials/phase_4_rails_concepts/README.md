# Phase 4: Rails Concepts & Service Objects

Learn professional Ruby patterns and Rails concepts before diving into a real Rails project.

## Files

### 1. **service_objects_intro.rb**
**What you'll learn:**
- What service objects are
- The basic pattern: `self.call` entry point + `initialize` + `call` method
- Why instance variables are powerful
- When to use service objects vs. functions
- Basic return values (true/false, hash)

**Time:** 25-35 minutes

**Concepts:**
- Class method `self.call` as entry point
- Instance variables `@var` shared across methods
- Single responsibility principle
- Simple return values

**Key takeaway:** Service objects organize business logic into reusable, testable classes.

### 2. **service_objects_intermediate.rb**
**What you'll learn:**
- Error handling in services (return objects, not just true/false)
- Result objects that contain success/errors/data
- Custom exceptions
- Chaining validations
- Optional parameters with defaults
- Real-world validation patterns

**Time:** 30-40 minutes

**Prerequisites:** Read intro first

**Concepts:**
- ServiceResult class for richer return values
- Custom exception classes
- Early validation (fail fast)
- Collecting all errors before returning
- Retry logic with custom exceptions
- Keyword arguments with defaults

**Key takeaway:** Rich return objects give callers better error information.

### 3. **service_objects_advanced.rb**
**What you'll learn:**
- Service composition (services calling services)
- Conductor pattern (orchestrating multiple services)
- Dependency injection (making services testable)
- Early exit patterns
- Side effects and transactions
- Complex workflows
- Flexible configuration

**Time:** 35-45 minutes

**Prerequisites:** Read intro + intermediate first

**Concepts:**
- One service calling another
- Orchestrating complex workflows
- Injecting dependencies for testability
- Handling failures with rollback
- Configuration/options for flexibility

**Key takeaway:** Services can coordinate to build complex, reliable workflows.

### 4. **service_objects_practice.rb**
**What you'll learn:**
- Apply patterns to realistic scenarios
- 6 progressive practice scenarios
- Build your own service

**Time:** 45-60 minutes (can do incrementally)

**Prerequisites:** Read all 3 tutorials first

**Scenarios:**
1. Simple service (book checkout)
2. Validation service (password reset)
3. Multi-step service (product purchase)
4. Service composition (user onboarding)
5. Retry logic (API integration)
6. Dependency injection (testable notification)

**Key takeaway:** Real-world problems need combinations of patterns.

## How to Use

### Study Progression

1. **Start:** `service_objects_intro.rb`
   - Read through sections 1-7
   - Understand the basic pattern
   - Don't worry if advanced concepts feel unfamiliar yet

2. **Learn:** `service_objects_intermediate.rb`
   - Read through sections 1-6
   - See how to handle errors gracefully
   - Understand result objects

3. **Deepen:** `service_objects_advanced.rb`
   - Read through sections 1-7
   - See how services work together
   - Understand dependency injection

4. **Practice:** `service_objects_practice.rb`
   - Work through scenarios 1-6 in order
   - Create test code in IRB/pry
   - Build the challenge service

### Using with IRB/Split Windows

Same workflow as Phase 3 tutorials:

```bash
cd ~/Documents/GitHub/learning/ruby/claude_teaching/tutorials/phase_4_rails_concepts/
nvim .
```

Then:
1. Open tutorial in right split (`leader + ff`)
2. Open IRB in left split (`ctrl + v`, `:terminal`, `irb`)
3. Read, copy code, paste into IRB, test

### Tips

**1. Understand the `self.call` Pattern**
```ruby
# This is the standard interface:
result = ServiceName.call(arg1, arg2)

# It's equivalent to:
result = ServiceName.new(arg1, arg2).call
```

Why? `self.call` is a convention in Rails. It means "do this thing."

**2. Think About Instance Variables**
Instead of passing data around:
```ruby
# Bad: pass everything everywhere
def step1(user, email, message)
  def step2(user, email, message)  # keep passing
    def step3(user, email, message)  # ugh
```

Use instance variables (good):
```ruby
def initialize(user, email, message)
  @user = user      # stored once
  @email = email    # available everywhere
  @message = message
end

def step1
  # use @user, @email, @message
end
```

**3. Error Handling is Important**
Services need to return success/failure + details:
```ruby
# Bad:
return false  # Caller doesn't know why

# Good:
{ success: false, errors: ["Email invalid", "Password too short"] }
```

**4. Test With Dependency Injection**
```ruby
# Production: uses real email sender
UserSignupService.call("paul@example.com", gateway: EmailGateway.new)

# Test: uses mock (no actual emails sent)
UserSignupService.call("paul@example.com", gateway: MockEmailGateway.new)
```

## When You're Ready for Real Rails

After completing this phase, you'll understand:
- How to organize business logic
- Error handling patterns
- How to compose complex workflows
- How to write testable code
- Professional Ruby conventions

This prepares you for Phase 5: Building a real Rails app where you'll use these patterns in controllers, models, and beyond.

## Common Questions

**Q: Isn't this just a class?**
A: Yes, but it's a *pattern*. The `self.call` convention, the validation approach, the return object—that's the pattern. It's how professional Rails developers organize code.

**Q: When do I use this vs. just a method?**
A: Use service objects when:
- ✓ Complex business logic (multiple steps)
- ✓ Multiple validations
- ✓ You'll test it thoroughly
- ✗ Simple utility (just use a method)

**Q: Why is dependency injection useful?**
A: Makes testing easy. You can swap real dependencies (email gateway) for mocks (test gateway) without changing the service code.

**Q: What's the difference between a service and a class?**
A: No difference technically. "Service object" is just a name for a class that does one specific thing and follows the `self.call` pattern. It's a design choice, not a language feature.

---

**Next:** After Phase 4, you'll be ready for Phase 5: Building a real Rails application.
