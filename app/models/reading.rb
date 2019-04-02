# frozen_string_literal: true

class Reading < ApplicationRecord
  belongs_to :session
  validates :number, presence: true
end
