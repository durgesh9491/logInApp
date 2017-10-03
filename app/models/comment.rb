class Comment < ActiveRecord::Base
  belongs_to :micropost
  validates :micropost_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  default_scope -> { order(created_at: :desc) }
  has_many :subcomments, :dependent => :destroy
  belongs_to :user, :foreign_key => "user_id"
  validates :creator_id, presence: true
  acts_as_votable
end
