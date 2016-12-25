require_relative 'caesar_cipher/caesar_cipher.rb'
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
	erb:hang_man
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


