puts 'Please provide a file path'.chomp
document_file_path = gets.chomp
# document_file_path = 'my/file/path/file.csv'

# if (!Document_file_path.nil? || Document_file_path != "") && Document_file_path.length >= 1
#   puts "File loaded!"
# else
#   puts "Please provide a filepath to a file"
# end

if document_file_path.nil?
  puts 'Field empty, please provide a file path'
elsif document_file_path == ''
  puts 'Empty quotes provided please enter something'
elsif document_file_path.length >= 1 && document_file_path.include?('.')
  puts 'File loaded!'
else
  puts "invalid your file path doesn't end in an extension"
end

puts 'Please provide a url'.chomp
url = gets.chomp
# url = 'www.amazon.com/page{14}'
if url.include?('{}') || url.include?('page')
  puts 'identified pagination url'
elsif url.include?('.com')
  puts 'US website'
else
  puts 'other website or empty string'
end
