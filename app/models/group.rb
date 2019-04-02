# frozen_string_literal: true

class Group < ApplicationRecord
  belongs_to :event
  has_many :sessions, dependent: :destroy

  def self.car_classes=(classes)
    self.car_classes = classes.to_json
  end
end
