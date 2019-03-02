class Report < ApplicationRecord
  belongs_to :session
  has_many :readings
end
