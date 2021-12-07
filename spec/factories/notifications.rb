FactoryBot.define do
  factory :notification do
    visitor_id { '' }
    visited_id { '' }
    library_id { '' }
    comment_id { nil }
    action { 'like' }
    checked { false }
  end
end
