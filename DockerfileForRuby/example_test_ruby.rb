require 'net/http'

response = Net::HTTP.get_response(URI.parse("http://www.google.com"))

if response.code == "200"
    puts "Web-страница доступна"
else
    puts "Web-страница недоступна"
end
