class SecondRecord < ApplicationRecord
  self.abstract_class = true

  def self.read_config()
    YAML::load(ERB.new(IO.read('config/second_database.yml')).result)
  end

  database = read_config
  establish_connection(database[Rails.env])
end
