include ActionDispatch::TestProcess

FactoryBot.define do
  factory :user do
    name { "testuser" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    after(:build) do |user|
      user.avatar.attach(io: File.open('spec/fixtures/torres1.jpeg'), filename: 'torres1.jpeg', content_type: 'image/jpeg')
    end

    trait :invalid do
      name { nil }
    end

    trait :update do
      name { 'updateuser' }
    end

    trait :admin do
      admin {true}
    end
  end
end
