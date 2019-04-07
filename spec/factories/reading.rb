FactoryBot.define do
  factory :reading do
    number {1}
    readings { %w[1 2].to_json }
    session
  end
end
