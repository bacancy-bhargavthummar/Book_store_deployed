# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :book
  belongs_to :user

  # validation
  validates :body, length: { maximum: 150, minimum: 1, message: 'must be present.' }

end
