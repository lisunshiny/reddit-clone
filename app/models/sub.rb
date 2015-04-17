class Sub < ActiveRecord::Base

  validates :moderator_id, :title, presence: true
  validates :title, uniqueness: true

  belongs_to :moderator,
    class_name: "User",
    foreign_key: :moderator_id,
    primary_key: :id

  has_many :post_subs,
    class_name: "PostSub",
    foreign_key: :sub_id

  has_many :posts, through: :post_subs, source: :post


end
