# http://nikalyuk.in/blog/2013/06/21/connecting-rails-project-with-multiple-databases/

namespace :second_db do
  # Ref: Rails::Application::Configuration#database_configuration
  def database_configuration(path)
    yaml = Pathname.new(path) if path

    config = if yaml && yaml.exist?
               require "yaml"
               require "erb"
               YAML.load(ERB.new(yaml.read).result) || {}
             elsif ENV["DATABASE_URL"]
               {}
             else
               raise "Could not load database configuration. No such file - #{path}"
             end
    config
  end

  desc "Configure the variables that rails need in order to look up for the db
    configuration in a different folder"
  task :set_custom_db_config_paths do
    # This is the minimum required to tell rails to use a different location
    # for all the files related to the database.
    ENV['SCHEMA'] = 'db/second_schema.rb'

    # NOTE(spesnova): In Rails 4.0.x, db:migrate task uses DATABASE_URL as database configuration if it exists.
    # After Rails 4.1.x, we may remove this line.
    # https://github.com/rails/rails/blob/4-0-stable/activerecord/lib/active_record/tasks/database_tasks.rb#L63
    ENV["DATABASE_URL"] = ENV["SECOND_DATABASE_URL"] if ENV["DATABASE_URL"] && ENV["SECOND_DATABASE_URL"]

    # Rewrite paths to load configuration for this db
    Rails.application.config.paths['db/migrate'] = ['db/second_migrate']
    Rails.application.config.paths['db/seeds.rb'] = ['db/second_seeds.rb']
    Rails.application.config.paths['config/database'] = ['config/second_database.yml']

    # Config to be set in db:load_config
    ActiveRecord::Base.configurations = database_configuration(Rails.root.join('config','second_database.yml'))
    ActiveRecord::Migrator.migrations_paths = 'db/second_migrate'

    # Reconnect to clear Spring cache
    ActiveRecord::Base.establish_connection
  end

  task :drop => :set_custom_db_config_paths do
    Rake::Task["db:drop"].invoke
  end

  task :create => :set_custom_db_config_paths do
    Rake::Task["db:create"].invoke
  end

  task :load_config => :set_custom_db_config_paths do
    Rake::Task["db:load_config"].invoke
  end

  task :migrate => :set_custom_db_config_paths do
    Rake::Task["db:migrate"].invoke
  end

  namespace :migrate do
    task :status => :set_custom_db_config_paths do
      Rake::Task["db:migrate:status"].invoke
    end

    task :down => :set_custom_db_config_paths do
      Rake::Task["db:migrate:down"].invoke
    end
  end

  task :rollback => :set_custom_db_config_paths do
    Rake::Task["db:rollback"].invoke
  end

  task :seed => :set_custom_db_config_paths do
    Rake::Task["db:seed"].invoke
  end

  namespace :schema do
    task :load => :set_custom_db_config_paths do
      Rake::Task["db:schema:load"].invoke
    end
  end

  namespace :test do
    task :prepare => :set_custom_db_config_paths do
      Rake::Task["db:test:prepare"].invoke
    end
  end

  task :version => :set_custom_db_config_paths do
    Rake::Task["db:version"].invoke
  end
end
