require_relative 'worker_helpers'

API_BASE_URI = 'http://cadetdynamo.herokuapp.com'
API_VER = '/api/v2/'

def process_queued_cadets
  @queue.poll(idle_timeout: ENV['IRON_IDLE_TIMEOUT'].to_i) do |cadet|
    username = JSON.parse cadet.body
    puts "received cadet: '#{username}'"
  end
end

puts "WORKER STARTED"
# puts "iron_task_id: #{@iron_task_id}"
# puts "params: #{params}"

setup_resources
process_queued_cadets
puts "WORKER FINISHED"

# saved_tutorials = HTTParty.get api_url("tutorials")
# saved_tutorials.each do |tutorial|
#   tutorial_url = api_url("tutorials/#{tutorial['id']}")
#   results = HTTParty.get tutorial_url
#   puts "Updated: #{tutorial['id']}"
# end
