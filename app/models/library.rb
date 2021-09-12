class Library < ApplicationRecord
  validates :name, :address, :study_space, :electrical_outlet, presence:true
  
  belongs_to :user

  has_one_attached :avatar
end
