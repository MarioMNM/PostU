class Comment < ApplicationRecord
  belongs_to :micropost
  belongs_to :user
  validates :content, presence: true, length: { maximum: 140 }

  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications
  has_noticed_notifications model_name: 'Notification'

  private

    def notify_recipient
      CommentNotification.with(comment: self, post: micropost).deliver_later(micropost.user)
    end

    def cleanup_notifications
      notifications_as_comment.destroy_all
    end
end
