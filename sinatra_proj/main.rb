require_relative 'caesar_cipher/caesar_cipher.rb'
require_relative 'Hangman/Hang_Man.rb'
require 'sinatra'
require 'sinatra/reloader'

configure do
    enable :sessions
    set :session_secret, "secret"
end


get '/' do
    #@@session = session  
	erb:index
end

get '/caesar_cipher.html' do
    translation = nil	 
	erb:caesar_cipher, locals: {translation: translation}
end

get '/hang_man.html' do
	session["game"] = Hangman.new
	@play = false
	@output = "<img src = \"hangaman_pics/Hangman_0.jpg\"> "	
	erb:hang_man
end

post '/runHangman' do	
	session["game"].engine_start(params["str"].to_s)
	@output = what_image
	state_assign
	puts "REEEEEEEEEEEEEEEE " + "#{session["game"].random_word}"
	erb:hang_man
end

post '/playHangman' do
	session["game"].reset
	@play = true
	@output = "<img src = \"hangaman_pics/Hangman_0.jpg\"> "		
	erb:hang_man
end

post '/runCaesar' do 	
    session["translation"] = caesar_cipher(params["str"].to_s, params["vals"].to_i)
    erb:caesar_cipher, locals: {translation: session["translation"]}
end

post '/backMenu' do
	redirect '/'
end

post '/caesar_but' do
	redirect 'caesar_cipher.html'
end

post '/hangman_but' do
	redirect 'hang_man.html'
end

helpers do
	def state_assign 
		@play = true
        @secret_code = session["game"].coded_word.split('').join(' ')      
	    @turns = session["game"].turns
	    @missed = session["game"].missed_words unless session["game"].misses == []	
	    @guess = session["game"].misses
	end

    def what_image
	    return "<img src = \"hangaman_pics/Hangman_0.jpg\"> " if session["game"].misses == 0
	    return "<img src = \"hangaman_pics/Hangman_1.jpg\"> " if session["game"].misses == 1
	    return "<img src = \"hangaman_pics/Hangman_2.jpg\"> " if session["game"].misses == 2
	    return "<img src = \"hangaman_pics/Hangman_3.jpg\"> " if session["game"].misses == 3
	    return "<img src = \"hangaman_pics/Hangman_4.jpg\"> " if session["game"].misses == 4
	    return "<img src = \"hangaman_pics/Hangman_5.jpg\"> " if session["game"].misses == 5
	    return "<img src = \"hangaman_pics/Hangman_6.jpg\"> " if session["game"].misses == 6
    end

end





