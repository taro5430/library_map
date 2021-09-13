class Library < ApplicationRecord
  validates :name, :address, :access, :study_space, :electrical_outlet, presence:true
  
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  belongs_to :user

  has_one_attached :avatar
end
