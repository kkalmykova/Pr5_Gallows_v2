
if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require_relative 'gallows_methods'

#The get_letters method will deal with the "taking" of the letters.
# It will return an array of letters of the hidden word.
letters = get_letters

errors = 0
correct_letters = []
incorrect_letters = []


while errors < 10
  print_status(letters, correct_letters, incorrect_letters, errors)

  puts "\nEnter the next letter"
  user_input = get_user_input

  result = check_result(user_input, letters, correct_letters, incorrect_letters)

  if result == -1
    #the letter wasn't guessed
    errors += 1
  elsif result == 1
    #the whole word was guessed
    break
  end
end

print_status(letters, correct_letters, incorrect_letters, errors)