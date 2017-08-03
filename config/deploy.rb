set :stages, %w(staging prod)
set :default_stage, "prod"
set :ssh_options, {:forward_agent => true}
require 'capistrano/ext/multistage'
