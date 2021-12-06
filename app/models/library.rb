class Library < ApplicationRecord
  validates :name, :address, :access, :study_space, :electrical_outlet, presence: true

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  belongs_to :user

  has_one_attached :avatar
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  has_many :notifications, dependent: :destroy

  def self.search(keyword)
    Library.where(["name LIKE ? or address LIKE ? or access LIKE? or detail LIKE ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
  end

  def create_notification_like!(current_user)
    notification = current_user.active_notifications.new(
      library_id: id,
      visited_id: user_id,
      action: 'like'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(library_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      library_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
