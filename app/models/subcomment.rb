class Subcomment < ActiveRecord::Base
  belongs_to :comment
  validates :comment_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  default_scope -> { order(created_at: :asc) }
  belongs_to :user, :foreign_key => "user_id"
  validates :creator_id, presence: true
  acts_as_votable
end
