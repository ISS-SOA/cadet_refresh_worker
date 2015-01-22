require 'yaml'
require 'json'
require 'httparty'
require 'aws-sdk'

def api_url(resource)
  URI.join(API_BASE_URI, API_VER, resource).to_s
end

def print_aws_creds
  creds = %w[IRON_ENV AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_REGION]

  puts "CREDENTIALS:"
  creds.each { |cred| puts "  #{cred}: #{ENV[cred]}" }
end

def update_env
  ENV['IRON_ENV'] ||= 'development'
  ENV.update YAML.load_file('./config/worker.yml')[ENV['IRON_ENV']]
rescue => e
  abort "Unable to load credentials from ./config/worker.yml: #{e}"
end

def setup_resources
  update_env
  @sqs = AWS::SQS.new(aws_region: ENV['AWS_REGION'])
  @queue = @sqs.queues.named('RecentCadet')
rescue => e
  puts "Error setting up resources: #{e}"
  print_aws_creds
end
