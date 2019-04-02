# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group, type: :model do
  it 'saves car_classes as json' do
    group = Group.new
    classes = %w[a b]
    group.car_classes = classes
    expect(group.car_classes.class).to eq String
    expect(JSON.parse(group.car_classes)).to eq classes
  end
end
