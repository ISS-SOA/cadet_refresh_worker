require_relative 'worker_helpers'

def process_queued_cadets
  @queue.poll(idle_timeout: ENV['IRON_IDLE_TIMEOUT'].to_i) do |cadet|
    cadet = JSON.parse cadet.body
    puts cadet
    HTTParty.get cadet['url']
  end
end

puts "WORKER STARTED"
# puts "iron_task_id: #{@iron_task_id}"
puts "IRON_ENV: #{ENV['IRON_ENV']}"
puts "params: #{params}"

setup_resources
process_queued_cadets
puts "WORKER FINISHED"
