# Project 4: Word Counter

## What You'll Build
A program that takes a sentence or paragraph of text from the user and reports: total word count, total character count (with and without spaces), the most frequent word, and a frequency count of every word. Good practice for string manipulation and hashes.

---

## Concepts You'll Practice

### String methods
Ruby strings have a rich set of built-in methods.

```ruby
text = "Hello World hello"
text.downcase          # => "hello world hello"
text.split             # => ["Hello", "World", "hello"] (splits on whitespace)
text.split(" ")        # same result
text.length            # character count including spaces
text.delete(" ").length # character count excluding spaces
text.gsub(/[^a-z ]/, "") # remove non-letter characters (regex)
```

### Hashes
Key-value pairs — like Python dicts. Perfect for counting word frequencies.

```ruby
counts = {}
counts["hello"] = 0       # set a key
counts["hello"] += 1      # increment
counts["hello"]           # => 1
counts.key?("hello")      # => true
```

### Building a frequency hash
A common pattern: loop through an array, use each element as a key, increment the count.

```ruby
words.each do |word|
  counts[word] = counts.fetch(word, 0) + 1
end
```
`fetch(key, default)` returns the value or the default if the key doesn't exist — cleaner than checking first.

### Sorting a hash
```ruby
counts.sort_by { |word, count| -count }  # sort by count descending
```

### Finding the max
```ruby
counts.max_by { |word, count| count }  # => ["hello", 2]
```

---

## Ruby Things to Notice

- `split` without arguments splits on any whitespace and removes empty strings — handy
- Hashes maintain insertion order in Ruby 1.9+ (unlike older versions)
- Block syntax: `do |param| ... end` and `{ |param| ... }` are equivalent; convention is `do/end` for multi-line, `{}` for one-liners

---

## Stretch Goals
1. Read text from a `.txt` file instead of user input (`File.read("file.txt")`)
2. Show the top 5 most frequent words as a ranked list
3. Ignore common "stop words" like "the", "a", "is", "and"
