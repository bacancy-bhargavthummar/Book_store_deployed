class Like < ApplicationRecord
  belongs_to :comment
  belongs_to :user

  # Validation
  validates_uniqueness_of :user_id, scope: [:comment_id]
end
