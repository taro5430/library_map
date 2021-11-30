FactoryBot.define do
  factory :comment do
    content { "test comment" }

    trait :update do
      content { "update comment" }
    end

    trait :invalid do
      content { nil }
    end
  end
end
