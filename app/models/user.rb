class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  has_many :libraries
  has_one_attached :avatar
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :liked_libraries, through: :likes, source: :library
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = 'guest_user'
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def already_liked?(library)
    likes.exists?(library_id: library.id)
  end
end
