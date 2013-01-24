# encoding: utf-8

require 'rvm/capistrano'
require 'bundler/capistrano'
load 'deploy/assets'

set :rvm_type, :system

set :application, 'monitoring.mgup.local'

set :scm, :git
set :repository,  'git@github.com:storkvist/monitoring.git'

server 'monitoring.mgup.local', :web, :app, :db, :primary => true
# server '213.171.61.189', :web, :app, :db, :primary => true
# ssh_options[:port] = 5190
set :deploy_to, '/var/monitoring'

set :user, 'root'
set :use_sudo, false
default_run_options[:pty] = true

set :normalize_asset_timestamps, false

# Очистка старых релизов после каждого деплоя.
after 'deploy:restart', 'deploy:cleanup'

namespace :deploy do
   task :start do

   end

   task :stop do

   end

   desc 'Рестарт приложения.'
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end

  #desc 'Копирование файла database.yml в новый релиз.'
  #task :copy_in_database_yml do
  #  run "cp #{shared_path}/config/database.yml #{latest_release}/config/"
  #end
end

#before 'deploy:assets:precompile', 'deploy:copy_in_database_yml'