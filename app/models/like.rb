class Like < ApplicationRecord
  belongs_to :library
  belongs_to :user
  validates_uniqueness_of :library_id, scope: :user_id
end
