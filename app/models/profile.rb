class Profile < ApplicationRecord
  belongs_to :user
  has_many :working_histories
end
