require 'json'
require 'httparty'

API_BASE_URI = 'http://cadetdynamo.herokuapp.com'
API_VER = '/api/v2/'

def api_url(resource)
  URI.join(API_BASE_URI, API_VER, resource).to_s
end

puts "Worker started!"
puts "My task_id is #{@iron_task_id}"
puts "Parameters: '#{params}'"

saved_tutorials = HTTParty.get api_url("tutorials")
saved_tutorials.each do |tutorial|
  tutorial_url = api_url("tutorials/#{tutorial['id']}")
  results = HTTParty.get tutorial_url
  puts "Updated: #{tutorial['id']}"
end
