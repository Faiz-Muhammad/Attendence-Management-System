class Attendence < ApplicationRecord


  belongs_to :user
  validates :user_id, presence: true
  attr_accessor :name, :user_id
  default_scope -> {order(created_at: :desc)}

end
