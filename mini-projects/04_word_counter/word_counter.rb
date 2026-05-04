# ============================================================
# PROJECT: Word Counter
# ============================================================
# SUMMARY:
#   Ask the user to enter a sentence or paragraph.
#   Then report:
#     - Total word count
#     - Total character count (with and without spaces)
#     - The most frequently used word
#     - A frequency table of all words
#
# CONCEPTS: String methods (split, downcase, gsub, length, delete),
#           hashes as counters, each_with_object / fetch,
#           max_by, sort_by, block syntax { |x| ... }
# ============================================================

# STEP 1 ─────────────────────────────────────────────────────
# Ask the user: "Enter some text:"
# Read their input with gets.chomp and store it in `text`.



# STEP 2 ─────────────────────────────────────────────────────
# Print the total word count.
# Hint: split the text on whitespace and count the pieces.
# "Hello world foo".split  => ["Hello", "world", "foo"]



# STEP 3 ─────────────────────────────────────────────────────
# Print the total character count INCLUDING spaces.
# Hint: just use .length on the original text.



# STEP 4 ─────────────────────────────────────────────────────
# Print the total character count EXCLUDING spaces.
# Hint: remove spaces first, then count.
# "hello world".delete(" ").length  => 10



# STEP 5 ─────────────────────────────────────────────────────
# Build a word frequency hash.
# Before counting, clean the text:
#   - Convert to lowercase with .downcase
#   - Remove punctuation with .gsub(/[^a-z\s]/, "")
#     (this regex keeps only lowercase letters and spaces)
#   - Split into words
#
# Then loop through the words array and count occurrences:
#   counts = {}
#   words.each do |word|
#     counts[word] = counts.fetch(word, 0) + 1
#   end
#
# Store the result in `word_counts`.



# STEP 6 ─────────────────────────────────────────────────────
# Find and print the most frequent word.
# Hint: word_counts.max_by { |word, count| count }
# This returns a [word, count] pair. Destructure it:
#   top_word, top_count = word_counts.max_by { |word, count| count }



# STEP 7 ─────────────────────────────────────────────────────
# Print the full frequency table, sorted from most to least frequent.
# Hint: word_counts.sort_by { |word, count| -count }
# This returns an array of [word, count] pairs. Loop through with each.
#
# Format the output like:
#   "the       : 4"
#   "quick     : 2"
#   "brown     : 1"



# ─── STRETCH GOALS ───────────────────────────────────────────
# 1. Read text from a .txt file instead of user input.
#    Hint: text = File.read("sample.txt")
#    Create a sample.txt with a paragraph to test with.
#
# 2. Show only the top 5 most frequent words.
#    Hint: .sort_by { ... }.first(5)
#
# 3. Filter out stop words before counting.
#    STOP_WORDS = ["the", "a", "an", "is", "it", "in", "on", "and", "or", "of"]
#    words = words.reject { |w| STOP_WORDS.include?(w) }
