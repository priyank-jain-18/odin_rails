require 'rest-client'


print "type what do you want to search:"
search = gets.chomp.split(' ').join('+')
response = RestClient.get "https://www.bing.com/search?q=#{search}"


puts "CODE: #{response.code}"
puts "COOKIES: #{response.cookies}"
puts "HEADERS: #{response.headers}"
puts "BODY: #{response.body}"


