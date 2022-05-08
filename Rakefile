require 'sinatra/activerecord/rake'

require 'standalone_migrations'
StandaloneMigrations::Tasks.load_tasks

namespace :db do
  task :load_config do
    require_relative 'app/corelian_campaign';
  end
end
