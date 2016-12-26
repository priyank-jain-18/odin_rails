require_relative 'Hang_Man.rb'
@@game = Hangman.new
@@game.generate_hangman_word


def what_image
	return "<img src = \"hangaman_pics/Hangman_0.jpg\"> " if @@game.misses == 0
	return "<img src = \"hangaman_pics/Hangman_1.jpg\"> " if @@game.misses == 1
	return "<img src = \"hangaman_pics/Hangman_2.jpg\"> " if @@game.misses == 2
	return "<img src = \"hangaman_pics/Hangman_3.jpg\"> " if @@game.misses == 3
	return "<img src = \"hangaman_pics/Hangman_4.jpg\"> " if @@game.misses == 4
	return "<img src = \"hangaman_pics/Hangman_5.jpg\"> " if @@game.misses == 5
	return "<img src = \"hangaman_pics/Hangman_6.jpg\"> " if @@game.misses == 6
end

def check_if_input_correct(letter)
	letter = @@game.input_letter
	check_if_part(letter)
end