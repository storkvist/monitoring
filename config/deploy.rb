require 'bundler/capistrano'

set :application, 'monitoring.mgup.local'

set :scm, :git
set :repository,  'git@github.com:storkvist/monitoring.git'

server 'matrix.mgup.local', :web, :app, :db, :primary => true

# Очистка старых релизов после каждого деплоя.
after 'deploy:restart', 'deploy:cleanup'


namespace :deploy do
   task :start do

   end

   task :stop do

   end
   
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end