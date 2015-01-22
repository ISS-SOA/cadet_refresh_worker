require_relative 'worker_helpers'

setup_resources

messages = [{username: 'soumya.ray'}, {username: 'chenlizhan'}]

messages.each do |msg|
  @queue.send_message(msg.to_json)
  puts "sent message: #{msg}"
end
