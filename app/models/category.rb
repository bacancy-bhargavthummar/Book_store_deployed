# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :books, dependent: :destroy

  # VALIDATION
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
