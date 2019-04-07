# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reading, type: :model do
  let(:session) { create(:session) }
  let(:reading) { build(:reading, session_id: session.id) }

  it 'can be deleted' do
    r = Reading.create!(reading.attributes.to_hash)
    expect(Reading.count).to eq(1)
    r.delete
    expect(Reading.count).to eq(0)
  end
end
