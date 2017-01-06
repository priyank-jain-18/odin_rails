require 'rest-client'
url = "http://localhost:3000/users"
puts RestClient.get(url)
url = "http://localhost:3000/users/show"
puts RestClient.get(url)
url = "http://localhost:3000/users/edit"
puts RestClient.get(url)
url = "http://localhost:3000/users/new"
puts RestClient.get(url)
url = "http://localhost:3000/users/create"
RestClient.post(url, {params: {name: "harmabe did 9/11"}})