FactoryBot.define do
  factory :user do
    email { 'test@local.com' }
    password { 'agreatepassword' }

    factory :admin do
      admin { true }
    end
  end
end
