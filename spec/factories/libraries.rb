include ActionDispatch::TestProcess

FactoryBot.define do
  factory :library do
    sequence(:name) { |n| "testlibrary#{n}" }
    sequence(:address) { |n| "testaddress#{n}" }
    sequence(:access) { |n| "teststation#{n}" }
    study_space { "50席以上" }
    electrical_outlet { "あり" }
    detail { 'testdetail' }
    association :user
    after(:build) do |library|
      library.avatar.attach(io: File.open('spec/fixtures/library_image.jpg'), filename: 'library_image.jpg', content_type: 'image/jpg')
    end

    trait :invalid do
      name { nil }
    end

    trait :update do
      detail { 'updatedetail' }
    end
  end
end
