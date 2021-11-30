class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  has_many :libraries
  has_one_attached :avatar
  has_many :comments

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = 'guest_user'
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
