require 'config_env'

desc "Upload worker with credentials (see.worker file)"
task :deploy do
  sh 'IRON_ENV=production iron_worker upload cadet_refresh'
end
