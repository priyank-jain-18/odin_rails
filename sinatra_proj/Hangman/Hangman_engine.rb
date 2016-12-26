require_relative 'Hang_Man.rb'
@@game = Hangman.new
@@game.generate_hangman_word


def check_if_input_correct(letter)
	letter = @@game.input_letter
	check_if_part(letter)
end