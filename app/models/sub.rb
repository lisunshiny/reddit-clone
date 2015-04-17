class Sub < ActiveRecord::Base

  validates :moderator_id, :title, presence: true
  validates :title, uniqueness: true

  belongs_to :moderator,
    class_name: "User",
    foreign_key: :moderator_id,
    primary_key: :id




end