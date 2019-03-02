class Group < ApplicationRecord
  belongs_to :event
  has_many :sessions
end
