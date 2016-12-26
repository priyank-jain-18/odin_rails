require_relative 'caesar_cipher/caesar_cipher.rb'
require_relative 'Hangman/Hangman_engine.rb'
require 'sinatra'
require 'sinatra/reloader'


get '/' do  
	erb:index
end

get '/caesar_cipher.html' do
    translation = nil	 
	erb:caesar_cipher, locals: {translation: translation}
end

get '/hang_man.html' do
	@play = false
	output = "<img src = \"hangaman_pics/Hangman_0.jpg\"> "	
	erb:hang_man, locals: {output: output,play: @play}
end

post '/runHangman' do
	@@game.engine_start(params["str"].to_s)
	output = what_image	

	@play = true
    secret_code = @@game.coded_word
	turns = @@game.turns
	missed = @@game.missed_words unless @@game.misses == []	
	guess = @@game.misses
	
	erb:hang_man, locals: {output: output,secret_code: secret_code, turns: turns, missed: missed,guess: guess,play: @play}

end

post '/playHangman' do
	secret_code = @@game.coded_word
	turns = @@game.turns
	missed = @@game.missed_words if @@game.misses == []
	
	guess = @@game.misses
	output = "<img src = \"hangaman_pics/Hangman_0.jpg\"> "	
	@play = true
	erb:hang_man, locals: {output: output,secret_code: secret_code, turns: turns, missed: missed,guess: guess,play: @play}
end

post '/runCaesar' do 	
    translation = caesar_cipher(params["str"].to_s, params["vals"].to_i)
    erb:caesar_cipher, locals: {translation: translation}
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


