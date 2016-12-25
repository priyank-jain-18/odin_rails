require_relative 'caesar_cipher/caesar_cipher.rb'
require 'sinatra'
require 'sinatra/reloader'


get '/' do  
	erb:index
end

get '/caesar_cipher.html' do
	erb:caesar_cipher
end