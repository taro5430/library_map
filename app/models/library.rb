class Library < ApplicationRecord
  validates :name, :address, :study_space, :electrical_outlet, presence:true
  
  belongs_to :user

  mount_uploader :image, ImageUploader
end
