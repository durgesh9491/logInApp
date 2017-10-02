class Subcomment < ActiveRecord::Base
  belongs_to :comment
  validates :comment_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  default_scope -> { order(created_at: :asc) }
end
