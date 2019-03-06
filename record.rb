require 'ritm'
#f927ea54-e7ce-4d8d-af5c-19213e3fb420
Ritm.configure do
  ssl_reverse_proxy.ca[:pem] = 'insecure_ca.crt'
  ssl_reverse_proxy.ca[:key] = 'insecure_ca.key'
end
# Get the last Number in the dir and then add one to create a new text file
dir = Dir["List/*"].sort_by{ |m| m.scan(/\d+/)[0].to_i }.last.gsub("List/", "").to_i
f = File.open("List/#{dir+=1}.txt", "a")
Ritm.on_request do |req|
		puts"[================================]"
		puts req.request_uri
		puts req
		puts"[================================]"
		f << "[================================]\n"
		f << req.request_uri.to_s + "\n"
		f << req.to_s + "\n"
		f << "[================================]\n"
end
Ritm.on_response do |_req, res|
end
Ritm.start
 
puts 'Hit enter to finish'
gets

Ritm.shutdown
