################################################################################################################
# This deploy recipe will deploy a project from a github repo to a VPS server
#
# Assumptions:
# * You are using VPS hosting with SSH access
# * Your deployment directory is located in /srv/www/
#
#################################################################################################################
#
# Change this to the name of the project. It should match the name of the Git repo.
# This will set the name of the project directory and become the subdomain
set :project, 'benjamingrobertson.github.io' # the GitHub project name
set :github_user, "benjamingrobertson" # Your GitHub username
set :domain_name, "benrobertson.io" # should be something like project.mydomain.com
set :user, 'deploy' # VPS hosting ssh username
set :domain, 'dev.benjamingrobertson.com' # IP or domain name to ssh to

set :use_sudo, false

#### You shouldn't need to change anything below ########################################################
default_run_options[:pty] = true
set :repository, "git@github.com:#{github_user}/#{project}.git" #GitHub clone URL
set :scm, "git"
set :scm_passphrase, "" # This is the passphrase for the ssh key on the server deployed to
set :branch, "master" # This is for a git branch if you want to deploy from something besides master
set :scm_verbose, true
set :applicationdir, "/var/www/html/#{domain_name}/"
set :keep_releases, 3

# Don't change this stuff, but you may want to set shared files at the end of the file ##################
# deploy config
set :deploy_to, applicationdir
set :deploy_via, :remote_cache

# roles (servers)
role :app, domain
role :web, domain
role :db, domain, :primary => true

set :format, :pretty
namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

after "deploy:symlink:release", "deploy:update_jekyll"

# Optional tasks ##########################################################################################
# for use with shared files (e.g. config files)
after "deploy:update_code" do
    run "cd #{release_path} && bundle exec jekyll build --config=_config_prod.yml"
end
after "deploy", "deploy:cleanup"
