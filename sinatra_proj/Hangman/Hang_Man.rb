require 'json'
class Hangman
	attr_accessor :misses, :correct, :random_word, :coded_word, :missed_words, :turns

	def initialize
		@misses = 0
		@correct = 0
		@turns = 0


		@random_word = nil
		@coded_word = nil
		@missed_words = Array.new

		@save_name = nil

	end

	def output_man

        man = "		 ___________.._______ <br>" +
        "| .__________))______| <br>" +
        "| | / /      #{@misses >= 1 ? '||' : ''} <br>" +
        "| |/ /       #{@misses >= 1 ? '||' : ''} <br>" +
        "| | /        #{@misses >= 1 ? '||.-\'\'.' : ''} <br>" +
        "| |/         #{@misses >= 1 ? '|/  _  \\' : ''} <br>" +
        "| |          #{@misses >= 1 ? '||  `/,|' : ''} <br>" +
        "| |          #{@misses >= 1 ? '(\\`_.\'' : ''} <br>" +
        "| |         #{@misses >= 1 ? '.-`--\'.' : ''} <br>" +
        "| |        #{@misses >= 3 ? '/Y': '  '} #{@misses >= 2 ? '. .' : ''} #{@misses >= 4 ? 'Y\\' : ''}  <br>" +
        "| |       #{@misses >= 3 ? '//' : '  '} #{@misses >= 2 ? '|   |' : ''} #{@misses >= 4 ? '\\\\' : ''} <br>" +
        "| |      #{@misses >= 3 ? '//' : '  '}  #{@misses >= 2 ? '| . |' : ''}  #{@misses >= 4 ? '\\\\' : ''} <br>"  +
        "| |     #{@misses >= 3 ? '\')' : '  '}   #{@misses >= 2 ? '|   |' : ''}   #{@misses >= 4 ? '(`' : ''}  <br>" +
        "| |          #{@misses >= 5? '||\'' : ''}#{@misses >= 6 ? '||' : ''} <br>" +
        "| |          #{@misses >= 5 ? '||' : ''} #{@misses >= 6 ? '||' : ''} <br>" +
        "| |          #{@misses >= 5 ? '||' : ''} #{@misses >= 6 ? '||' : ''} <br>" +
        "| |          #{@misses >= 5 ? '||' : ''} #{@misses >= 6 ? '||' : ''} <br>" +
        "| |         #{@misses >= 5 ? '/ |' : ''} #{@misses >= 6 ? '| \\' : ''} <br>" +
        "\"\"\"\"\"\"\"\"\"\"|_#{@misses >= 5 ? '`-\'' : '   '} #{@misses >= 6 ? '`-\' ' : '    '} |\"\"\"| <br>" +
        "|\"|\"\"\"\"\"\"\"\\ \\        '\"|\"| <br>" +
        "| |        \\ \\         | | <br>" +
        ": :         \\ \\        : :   <br>" +
        ". .          `'        . . <br>"       
       # print "Missed: " unless @missed_words.empty?
        #@missed_words.each {|letter| print letter.upcase + ', ' } unless @missed_words.empty?

        return man
    end

    def generate_hangman_word
    	words = File.readlines('dictionary.txt')
    	not_good_word = true
    	
    	while not_good_word
    		picked_word = words[rand(words.size)].gsub(/\s+/, "")
    		not_good_word = false if picked_word.length >= 5 && picked_word.length <= 12
    	end
    	@coded_word = "_" * picked_word.gsub(/\s+/, "").length

       	return picked_word.gsub(/\s+/, "")
    end

    def input_letter
    	inp_char = 'gg'
    	while inp_char.length != 1 && inp_char.is_a?(String) && inp_char =~ /[A-Za-z]/
    	    print "<br>Enter a character: "
            inp_char = gets.chomp
            save_game if inp_char == 'save'
            load_game if inp_char == 'load'
    	    puts "please enter a SINGLE charater " if inp_char.length != 1
    	    puts "please enter a letter not a number" if inp_char.is_a?(Integer)    	  
        end
        return inp_char 
    end


    def check_if_part(letter)
    	@random_word.each_char.with_index do |char,index|
    		if letter == char
    			@coded_word[index] = letter
    			@correct += 1
    			@turns += 1
    		end
    	end

    	unless @random_word.include?(letter)
    		@misses += 1
    		@missed_words << letter
    	end
    end

    def win?
    	return true if @correct == @random_word.length && !lose?
    	return false
    end

    def lose? 
    	return true if @misses >= 6
    	return false
    end

    def engine_start
    	@random_word = generate_hangman_word
    	output_man    	

    	while win? == false && lose?   == false

    		letter = input_letter
    		check_if_part(letter)
    		output_man
    	end
    	puts "<br>YOU LOSE, the correct word is #{@random_word}" if lose?
    	puts "<br>YOU WIN CONGRATS" if win?
    end


end


game = Hangman.new
game.output_man



