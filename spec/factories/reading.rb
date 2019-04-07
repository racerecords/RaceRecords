FactoryBot.define do
  factory :reading do
    number {1}
    readings { '[1,2]' }
    session
  end
end
