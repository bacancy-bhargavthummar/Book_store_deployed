# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comment, dependent: :destroy
  has_many :likes, dependent: :destroy 
  has_many :book_sellers, dependent: :destroy, foreign_key: :seller_id
  # has_many :books, through: :book_sellers
  has_many :carts, dependent: :destroy
  has_many :favorites, dependent: :destroy 
  has_many :books, through: :favorites
  enum gender: %i[male female other]
  
  # VALIDATION
  validates :name, presence: true
  validates :phone_no, format: { with: /[\+0-9]{1,4}\s*[0-9]{10}/ , message: "must be valid" }
  validates :gender, presence: { message: "must be checked"}
  # scope :searching, ->(s) { Book.joins(:category).where('books.name LIKE ? OR books.author LIKE ? OR books.isbn LIKE ? OR categories.name LIKE ? ', "%#{s}%", "%#{s}%", "%#{s}%", "%#{s}%") }
  
end
