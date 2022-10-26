
def get_letters
  secret_word = gets.chomp()

  if secret_word == ''
    abort 'Please, enter the secret word'
  end
  #split the word into letters
  return secret_word.encode('UTF-8').split('')
end

# asking the user, which letter they want to try as a next move.
def get_user_input
  letter = ''
  # waiting for user's input
  while letter == ''
    # asking the letter
    letter = STDIN.gets.encode('UTF-8').chomp
  end
  return letter
end

#0 - if the letter is in the word (or has already been named) and the game continues
#-1 - if the entered letter is not in the word
#1 - if the whole word is guessed entirely
def check_result(user_input, letters, correct_letters, incorrect_letters)
  # If the entered letter is already in the list of "correct" or "incorrect" immediately
  # return 0, since nothing has changed, the game will continue.
  if correct_letters.include?(user_input) || incorrect_letters.include?(user_input)
    return 0
  end

  if letters.include? user_input
    # If the word contains a letter, write it to the array of "correct" letters
    correct_letters << user_input

    #we make an additional check - whether this letter in the word is guessed entirely.
    #uniq method called on an array returns an array, but no duplicated
    # elements. If a letter occurs twice in a word, we need to put it away

    #letters.uniq.sort contains all the unique letters of the word in
    #alphabetical order.
    if correct_letters.uniq.sort == letters.uniq.sort
      # word is guessed
      return 1
    else
      # letter is guessed
      return 0
    end
  else
    # incorrect letter was entered
    incorrect_letters << user_input
    return -1
  end
end

def get_word_for_print(letters, correct_letters)
  result = ''

  # Go through the letters of the secret word
  for item in letters do
    if correct_letters.include?(item)
      # If this letter has already been guessed (it is in the array of "good" letters), it
      # will be displayed as is.
      result += item + ' '
    else
      result += '__ '
    end
  end

  return result
end

def print_status(letters, correct_letters, incorrect_letters, errors)
  puts "Secret word: #{get_word_for_print(letters, correct_letters)}\n"
  puts "Mistakes (#{errors}): #{incorrect_letters.join(', ')}"

  if errors >= 10
    puts 'You lost.'
  else
    if correct_letters.uniq.sort == letters.uniq.sort
      puts "You won!\n\n"
    else
      puts 'You have attempts left: ' + (10 - errors).to_s
    end
  end
end