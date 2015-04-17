class PostSub < ActiveRecord::Base

  validates :sub_id, :post, presence: true
  validates :post, uniqueness: { scope: :sub_id,
    message: "can only be shared once with sub" }

  belongs_to :sub,
    class_name: "Sub",
    foreign_key: :sub_id

  belongs_to :post,
    class_name: "Post",
    foreign_key: :post_id,
    inverse_of: :post_subs


end
