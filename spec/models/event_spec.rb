# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  let (:event) { build(:event) }

  it 'can be deleted' do
    e = Event.create!(event.attributes.to_hash)
    expect(Event.count).to eq(1)
    e.delete
    expect(Event.count).to eq(0)
  end
end
