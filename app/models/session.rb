class Session < ApplicationRecord
  belongs_to :group
  has_many :reports
end