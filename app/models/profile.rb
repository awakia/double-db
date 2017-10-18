class Profile < SecondRecord
  belongs_to :user
  has_many :working_histories
end
