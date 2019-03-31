class Session < ApplicationRecord
  belongs_to :group
  has_many :readings, dependent: :destroy
end
