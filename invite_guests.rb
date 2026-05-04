puts 'what is your name?'
name = gets.chomp.split.map(&:capitalize).join(' ')
bride = 'Andreea'
groom = 'Paul'

if name == bride
  puts "Hi beautiful #{bride}, you are getting married to the handsome #{groom}!"
elsif name == groom
  puts "Hi handsome #{groom}, you are getting married to the beautiful #{bride}!"
else
  puts "Hello, #{name} welcome our guest!"
end
