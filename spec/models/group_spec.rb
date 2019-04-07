# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group, type: :model do
  let (:group) { build(:group) }
  let (:event) { create(:event) }

  it 'saves car_classes as json' do
    classes = %w[a b]
    group.car_classes = classes
    expect(group.car_classes.class).to eq String
    expect(JSON.parse(group.car_classes)).to eq classes
  end

  it 'can be deleted' do
    group.event_id = event.id
    g = Group.create!(group.attributes.to_hash)
    expect(Group.count).to eq(1)
    g.delete
    expect(Group.count).to eq(0)
  end
end
