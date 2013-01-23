# encoding: utf-8

require 'bundler/capistrano'

set :application, 'monitoring.mgup.local'

set :scm, :git
set :repository,  'git@github.com:storkvist/monitoring.git'

server 'monitoring.mgup.local', :web, :app, :db, :primary => true
set :deploy_to, '/var/monitoring'

set :user, 'root'
set :use_sudo, false

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

  desc 'Копирование файла database.yml в новый релиз.'
  task :copy_in_database_yml do
    run "cp #{shared_path}/config/database.yml #{latest_release}/config/"
  end
end

before 'deploy:assets:precompile', 'deploy:copy_in_database_yml'