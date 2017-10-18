class WorkingHistory < ApplicationRecord
  belongs_to :profile

  establish_connection :second
end
