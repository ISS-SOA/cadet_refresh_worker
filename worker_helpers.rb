require 'yaml'
require 'json'
require 'httparty'
require 'aws-sdk'

def api_url(resource)
  URI.join(API_BASE_URI, API_VER, resource).to_s
end

def update_env
  env = ENV['IRON_ENV'] || 'development'
  puts "UPDATE_ENV: Running in #{env} environment"
  ENV.update YAML.load_file('./config/worker.yml')[env]
rescue => e
  abort "Unable to load credentials from ./config/worker.yml: #{e}"
end

def setup_resources
  update_env
  @sqs = AWS::SQS.new(aws_region: ENV['AWS_REGION'])
  @queue = @sqs.queues.named('RecentCadet')
  puts "SETUP_RESOURCES: SQS queue found at #{ENV['AWS_REGION']}"
rescue => e
  puts "Error setting up resources: #{e}"
  print_aws_creds
end
