# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Session, type: :model do
  let(:group) { create(:group) }
  let(:session) { build(:session, group_id: group.id) }

  it 'can be deleted' do
    s = Session.create!(session.attributes.to_hash)
    expect(Session.count).to eq(1)
    s.delete
    expect(Session.count).to eq(0)
  end
end
